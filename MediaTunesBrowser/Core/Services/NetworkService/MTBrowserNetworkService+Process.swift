//
//  MTBrowserNetworkService+Process.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

extension MTBrowserNetworkService {
    func process<T>(
        httpRequest: NetworkRequest,
        httpURLResponse: HTTPURLResponse,
        data: Data
    ) throws -> T {
        let decoder = JSONDecoder()
        switch httpRequest {
        case .search:
            let data = try decoder.decode(SearchResponseModel.self, from: data)
            return data as! T
        }
    }
}
