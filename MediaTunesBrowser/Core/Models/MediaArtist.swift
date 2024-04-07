//
//  MediaArtist.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct MediaArtist {
    /// id артиста
    let id: Int?
    /// наименование артиста
    let name: String?
    /// ссылка на артиста на iTunes
    let viewURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "artistId"
        case name = "artistName"
        case viewURL = "artistViewUrl"
    }
}
