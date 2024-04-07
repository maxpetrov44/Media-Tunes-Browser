//
//  NetworkResult.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

 enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
    
     var isSuccess: Bool {
         switch self {
         case .success: return true
         default: return false
         }
     }
     
     var isError: Bool {
         switch self {
         case .failure: return true
         default: return false
         }
     }
     
     var value: T? {
         switch self {
         case .success(let value): return value
         default: return nil
         }
     }
     
     var error: NetworkError? {
         switch self {
         case .failure(let error): return error
         default: return nil
         }
     }
}
