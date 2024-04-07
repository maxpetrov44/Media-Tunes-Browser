//
//  NetworkServiceHelper.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

final class NetworkServiceHelper {
    static func urlQueryItemsFrom(
        key: String,
        value: Any
    ) -> [URLQueryItem] {
        switch value {
        case let dictionary as [String: Any]:
            return dictionary.flatMap { nestedKey, value in
                urlQueryItemsFrom(key: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            if array.isEmpty {
                return [URLQueryItem(name: key + "[0]", value: "")]
            }
            return array.enumerated().flatMap {
                urlQueryItemsFrom(key: "\(key)[\($0.offset)]", value: $0.element)
            }
        case let set as Set<AnyHashable>:
            if set.isEmpty {
                return [URLQueryItem(name: key + "[0]", value: "")]
            }
            return set.enumerated().flatMap {
                urlQueryItemsFrom(key: "\(key)[\($0.offset)]", value: $0.element)
            }
        default: return [URLQueryItem(name: key, value: "\(value)")]
        }
    }
}
