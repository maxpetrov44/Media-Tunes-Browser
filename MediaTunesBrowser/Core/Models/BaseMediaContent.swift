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
        func getArtist() throws -> MediaArtist? {
            if let artistContainer = try? decoder.container(keyedBy: MediaArtist.CodingKeys.self),
               let id = try artistContainer.decodeIfPresent(Int.self, forKey: .id) {
                return .init(
                    id: id,
                    name: try artistContainer.decodeIfPresent(String.self, forKey: .name),
                    viewURL: try artistContainer.decodeIfPresent(URL.self, forKey: .viewURL)
                )
            }
            return nil
        }
        func getCollection() throws -> MediaCollection? {
            if let collectionContainer = try? decoder.container(keyedBy: MediaCollection.CodingKeys.self),
               let id = try collectionContainer.decodeIfPresent(Int.self, forKey: .id) {
                return .init(
                    id: id,
                    name: try collectionContainer.decodeIfPresent(String.self, forKey: .name),
                    explicitness: try collectionContainer.decodeIfPresent(MediaExplicitness.self, forKey: .explicitness),
                    censoredName: try collectionContainer.decodeIfPresent(String.self, forKey: .censoredName),
                    viewURL: try collectionContainer.decodeIfPresent(URL.self, forKey: .viewURL)
                )
            }
            return nil
        }
        func getTrack() throws -> MediaTrack? {
            if let trackContainer = try? decoder.container(keyedBy: MediaTrack.CodingKeys.self),
               let id = try trackContainer.decodeIfPresent(Int.self, forKey: .id) {
                return .init(
                    id: id,
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
            artist = try getArtist()
            track = try getTrack()
        case .collection:
            artist = try getArtist()
            collection = try getCollection()
        case .artist:
            artist = try getArtist()
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
