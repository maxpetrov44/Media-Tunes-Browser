//
//  MediaCollection.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaCollection {
    /// id коллекции
    let id: Int?
    /// наименование коллекции
    let name: String?
    /// уровень цензурирования
    let explicitness: MediaExplicitness?
    ///  цензурированное наименование
    let censoredName: String?
    /// url на iTunes
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "collectionId"
        case name = "collectionName"
        case explicitness = "collectionExplicitness"
        case censoredName = "collectionCensoredName"
        case viewURL = "collectionViewUrl"
    }
}
