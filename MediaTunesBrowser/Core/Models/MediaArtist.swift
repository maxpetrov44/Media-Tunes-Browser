//
//  MediaArtist.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaArtist {
    let id: Int
    let name: String?
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "artistId"
        case name = "artistName"
        case viewURL = "artistViewUrl"
    }
}
