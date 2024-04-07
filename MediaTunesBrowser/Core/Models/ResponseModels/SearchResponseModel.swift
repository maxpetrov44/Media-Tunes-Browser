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
    
    enum CodingKeys: CodingKey {
        case resultCount
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resultCount = try container.decode(Int.self, forKey: .resultCount)
        self.results = try container.decode([BaseMediaContent].self, forKey: .results)
    }
}
