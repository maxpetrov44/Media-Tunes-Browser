//
//  MediaWrapperType.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

enum MediaWrapperType: String, Decodable {
    case track
    case collection
    case artist
    case audiobook
}
