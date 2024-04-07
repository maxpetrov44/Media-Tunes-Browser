//
//  MediaTrack.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaTrack {
    let id: Int
    let name: String?
    let explicitness: MediaExplicitness?
    let censoredNamed: String?
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case explicitness = "trackExplicitness"
        case censoredNamed = "trackCensoredName"
        case viewURL = "trackViewUrl"
    }
}
