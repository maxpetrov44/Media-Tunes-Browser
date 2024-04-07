//
//  SearchResponseModel.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import Foundation

struct SearchResponseModel: Decodable {
    let resultCount: Int
    let results: [BaseMediaContent]
}
