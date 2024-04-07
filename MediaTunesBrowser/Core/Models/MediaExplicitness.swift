//
//  MediaExplicitness.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

enum MediaExplicitness: String, Decodable {
    /// содержит жестокий контент
    case explicit
    /// цензурирован
    case cleaned
    /// не содерджит жестокий контент
    case notExplicit
}
