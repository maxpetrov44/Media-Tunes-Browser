//
//  NetworkRequest+Parameters.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation


extension NetworkRequest {
    var parameters: [String: Any] {
        switch self {
        case .search(let searchParameters):
            return searchParameters
        }
    }
}
