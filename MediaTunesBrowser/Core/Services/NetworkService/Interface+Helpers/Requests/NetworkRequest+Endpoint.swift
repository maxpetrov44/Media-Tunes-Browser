//
//  NetworkRequest+Endpoint.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

extension NetworkRequest {
    var endpoint: String {
        switch self {
        case .search: return "/search"
        }
    }
}
