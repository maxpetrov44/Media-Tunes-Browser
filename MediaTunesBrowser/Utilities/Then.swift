//
//  Then.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 06.04.2024.
//

import Foundation
import UIKit

protocol Then {}

extension Then where Self: Any {
    @discardableResult
    func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
}

extension Then where Self: AnyObject {
    @discardableResult
     func then( _ block: (Self) -> Void ) -> Self {
        block(self)
        return self
    }
    
}

extension Then where Self: UIView {
    @discardableResult
    func then( useAutolayout: Bool = true, _ block: (Self) -> Void ) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = !useAutolayout
        block(self)
        return self
    }
}

extension Optional {
    @discardableResult
    func then<T>( _ block: ( Wrapped ) throws -> T ) rethrows -> T? {
        switch self {
        case .none: return nil
        case .some( let value ): return try block( value )
        }
    }
}

extension NSObject: Then {}
