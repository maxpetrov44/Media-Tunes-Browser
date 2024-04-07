//
//  NetworkError.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation

enum NetworkError: Error {
    /// Запрос был отменён.
    case cancelled
    /// Общая ошибка, обычно при недоступности сервера/сети
    case generalError(NSError?)
    /// API вернул пустой ответ там, где этого быть не должно
    case apiEmptyAnswer(String?)
    /// Ответ сервера в неправильном или неизвестном формате
    case invalidResponseFormat(message: String? = nil)
}

extension DecodingError {
    var debugDescription: String? {
        switch self {
        case .keyNotFound(_, let context):
            return context.debugDescription
        case .typeMismatch(_, let context):
            return context.debugDescription
        case .valueNotFound(_, let context):
            return context.debugDescription
        case .dataCorrupted(let context):
            return context.debugDescription
        default:
            return localizedDescription
        }
    }
}
