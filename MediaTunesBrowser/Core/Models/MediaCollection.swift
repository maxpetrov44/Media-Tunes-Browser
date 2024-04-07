//
//  MediaCollection.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaCollection {
    let id: Int
    let name: String?
    let explicitness: MediaExplicitness?
    let censoredName: String?
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "collectionId"
        case name = "collectionName"
        case explicitness = "collectionExplicitness"
        case censoredName = "collectionCensoredName"
        case viewURL = "collectionViewUrl"
    }
}
