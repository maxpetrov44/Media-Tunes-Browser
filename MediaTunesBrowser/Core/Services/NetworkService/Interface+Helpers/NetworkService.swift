//
//  NetworkService.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

protocol NetworkService {
    @discardableResult
    func send<T>(
        request: NetworkRequest,
        queue: DispatchQueue,
        startRequestImmediately: Bool,
        completion: @escaping (NetworkResult<T>) -> Void
    ) -> URLSessionTask?
    
    @discardableResult
    func send(
        request: NetworkRequest,
        queue: DispatchQueue,
        startRequestImmediately: Bool,
        completion: ((NetworkResult<Void>) -> Void)?
    ) -> URLSessionTask?
}

extension NetworkService {
    @discardableResult
    func send<T>(
        request: NetworkRequest,
        queue: DispatchQueue = .main,
        startRequestImmediately: Bool = true,
        completion: ((NetworkResult<T>) -> Void)? = nil
    ) -> URLSessionTask? {
        return send(
            request: request,
            queue: queue,
            startRequestImmediately: startRequestImmediately
        ) { (result: NetworkResult<T>) in
            completion?(result)
        }
    }
    
    @discardableResult
    func send(
        request: NetworkRequest,
        queue: DispatchQueue = .main,
        startRequestImmediately: Bool = true,
        completion: ((NetworkResult<Void>) -> Void)? = nil
    ) -> URLSessionTask? {
        return send(
            request: request,
            queue: queue,
            startRequestImmediately: startRequestImmediately,
            completion: completion
        )
    }
}
