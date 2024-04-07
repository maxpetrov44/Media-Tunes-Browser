//
//  BaseMediaContent.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct BaseMediaContent: Decodable {
    let kind: MediaKind?
    let artist: MediaArtist?
    let collection: MediaCollection?
    let track: MediaTrack?
    private let wrapperType: MediaWrapperType
    let artworkURL: URL?
    let country: String?

    private enum CodingKeys: String, CodingKey {
        case kind, wrapperType, country
    }
    private enum LargeArtworkCodingKeys: String, CodingKey {
        case artworkUrl60
    }
    private enum MediumArtworkCodingKeys: String, CodingKey {
        case artworkUrl30
    }
    private enum SmallArtworkCodingKeys: String, CodingKey {
        case artworkUrl100
    }
    
    init(from decoder: any Decoder) throws {
        var artist: MediaArtist?
        var collection: MediaCollection?
        var track: MediaTrack?
        
        /// достает артиста
        /// - Parameter idRequired: флаг `строгой` необходимости id
        func getArtist(idRequired: Bool) throws -> MediaArtist? {
            if let artistContainer = try? decoder.container(keyedBy: MediaArtist.CodingKeys.self) {
                return .init(
                    id: idRequired
                    ? (try artistContainer.decodeIfPresent(Int.self, forKey: .id))
                    : (try? artistContainer.decodeIfPresent(Int.self, forKey: .id)),
                    name: try artistContainer.decodeIfPresent(String.self, forKey: .name),
                    viewURL: try artistContainer.decodeIfPresent(URL.self, forKey: .viewURL)
                )
            }
            return nil
        }
        /// достает коллекцию
        /// - Parameter idRequired: флаг `строгой`  необходимости id
        func getCollection(idRequired: Bool) throws -> MediaCollection? {
            if let collectionContainer = try? decoder.container(keyedBy: MediaCollection.CodingKeys.self) {
                return .init(
                    id: idRequired
                    ? (try collectionContainer.decodeIfPresent(Int.self, forKey: .id))
                    : (try? collectionContainer.decodeIfPresent(Int.self, forKey: .id)),
                    name: try collectionContainer.decodeIfPresent(String.self, forKey: .name),
                    explicitness: try collectionContainer.decodeIfPresent(MediaExplicitness.self, forKey: .explicitness),
                    censoredName: try collectionContainer.decodeIfPresent(String.self, forKey: .censoredName),
                    viewURL: try collectionContainer.decodeIfPresent(URL.self, forKey: .viewURL)
                )
            }
            return nil
        }
        /// достает трек
        /// - Parameter idRequired: флаг `строгой` необходимости id
        func getTrack(idRequired: Bool) throws -> MediaTrack? {
            if let trackContainer = try? decoder.container(keyedBy: MediaTrack.CodingKeys.self) {
                return .init(
                    id: idRequired
                    ? (try trackContainer.decodeIfPresent(Int.self, forKey: .id))
                    : (try? trackContainer.decodeIfPresent(Int.self, forKey: .id)),
                    name: try trackContainer.decodeIfPresent(String.self, forKey: .name),
                    explicitness: try trackContainer.decodeIfPresent(MediaExplicitness.self, forKey: .explicitness),
                    censoredNamed: try trackContainer.decodeIfPresent(String.self, forKey: .censoredNamed),
                    viewURL: try trackContainer.decodeIfPresent(URL.self, forKey: .viewURL)
                )
            }
            return nil
        }
        
        let mediaContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.wrapperType = try mediaContainer.decode(MediaWrapperType.self, forKey: .wrapperType)
        self.kind = try? mediaContainer.decode(MediaKind.self, forKey: .kind)
        self.country = try mediaContainer.decode(String.self, forKey: .country)
        switch wrapperType {
        case .track, .audiobook:
            artist = try getArtist(idRequired: false)
            track = try getTrack(idRequired: true)
        case .collection:
            artist = try getArtist(idRequired: false)
            collection = try getCollection(idRequired: true)
        case .artist:
            artist = try getArtist(idRequired: true)
        }
        self.artist = artist
        self.track = track
        self.collection = collection
        var artworkURL: URL?
        if let artworkContainer = try? decoder.container(keyedBy: MediumArtworkCodingKeys.self) {
            artworkURL = try artworkContainer.decodeIfPresent(URL.self, forKey: .artworkUrl30)
        } else if let artworkContainer = try? decoder.container(keyedBy: LargeArtworkCodingKeys.self) {
            artworkURL = try artworkContainer.decodeIfPresent(URL.self, forKey: .artworkUrl60)
        } else if let artworkContainer = try? decoder.container(keyedBy: SmallArtworkCodingKeys.self) {
            artworkURL = try artworkContainer.decodeIfPresent(URL.self, forKey: .artworkUrl100)
        }
        self.artworkURL = artworkURL
    }
}
