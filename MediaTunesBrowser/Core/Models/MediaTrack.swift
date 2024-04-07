//
//  MediaTrack.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaTrack {
    /// id трека
    let id: Int?
    /// наименование трека
    let name: String?
    /// уровень цензурирования
    let explicitness: MediaExplicitness?
    /// цензурированное наименование
    let censoredNamed: String?
    /// url на iTunes
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case explicitness = "trackExplicitness"
        case censoredNamed = "trackCensoredName"
        case viewURL = "trackViewUrl"
    }
}
