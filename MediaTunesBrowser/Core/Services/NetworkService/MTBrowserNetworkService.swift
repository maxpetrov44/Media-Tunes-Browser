//
//  MTBrowserNetworkService.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

final class MTBrowserNetworkService: NetworkService {
    var networConfiguration: NetworkConfiguration!
    
    private var urlSession: URLSession!
    
    init(networConfiguration: NetworkConfiguration) {
        self.networConfiguration = networConfiguration
        
        urlSession = makeURLSession()
    }
    
    func send<T>(
        request: NetworkRequest,
        queue: DispatchQueue,
        startRequestImmediately: Bool,
        completion: @escaping (NetworkResult<T>) -> Void
    ) -> URLSessionTask? {
        let request = urlSession.dataTask(with: urlRequest(request)) { [unowned self] data, response, error in
            do {
                guard error == nil else {
                    if error!._code == -999 {
                        throw NetworkError.cancelled
                    }
                    throw NetworkError.generalError(error as NSError?)
                }
                
                // проверяем пршла ли какая нибудь информация
                guard let httpURLResponse = response as? HTTPURLResponse,
                      let data = data else {
                    throw NetworkError.apiEmptyAnswer("no data")
                }
                
                // проверяем валидность ответа
                let value: T = try self.process(
                    httpRequest: request,
                    httpURLResponse: httpURLResponse,
                    data: data
                )
                
                queue.async {
                    completion(.success(value))
                }
            } catch let error as DecodingError {
                queue.async {
                    completion(.failure(.invalidResponseFormat(message: error.debugDescription)))
                }
            } catch let error {
                if let networkError = error as? NetworkError {
                    queue.async {
                        completion(.failure(networkError))
                    }
                }
            }
        }
        if startRequestImmediately {
            request.resume()
        }
        return request
    }
    
    func send(
        request: NetworkRequest,
        queue: DispatchQueue,
        startRequestImmediately: Bool,
        completion: ((NetworkResult<Void>) -> Void)?
    ) -> URLSessionTask? {
        return send(
            request: request,
            queue: queue,
            startRequestImmediately: startRequestImmediately
        ) { (result: NetworkResult<Void>) in
            completion?(result)
        }
    }
}

private extension MTBrowserNetworkService {
    func makeURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    
    func urlRequest(_ request: NetworkRequest) -> URLRequest {
        let endpointURL = networConfiguration.apiRoot.appendingPathComponent(request.endpoint)
        let requestParameters = request.parameters
            .sorted { $0.key < $1.key }
            .flatMap { NetworkServiceHelper.urlQueryItemsFrom(key: $0.key, value: $0.value) }
        var url = endpointURL
        if var components = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false) {
            components.queryItems = requestParameters
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

            components.url.then { url = $0 }
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.GET.rawValue
        
        return urlRequest
    }
}
