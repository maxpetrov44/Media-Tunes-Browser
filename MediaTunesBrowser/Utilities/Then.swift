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
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    @discardableResult
    func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
}

extension Then where Self: AnyObject {
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    @discardableResult
     func then( _ block: (Self) -> Void ) -> Self {
        block(self)
        return self
    }
    
    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
     func `do`(_ block: (Self) -> Void) {
        block(self)
    }
    
}

extension Then where Self: UIView {
    
    /// Makes it available to set properties with closures just after initializing.
    /// By defaut turns off `translatesAutoresizingMaskIntoConstraints` property.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    @discardableResult
    func then( useAutolayout: Bool = true, _ block: (Self) -> Void ) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = !useAutolayout
        block(self)
        return self
    }
}

extension Optional {

    /// Executes given block with unwrapped value of optional as parameter when said optional is not `nil`.
    ///
    ///        let nonNilOptional: Int? = 1
    ///        nonNilOptional.then { print( $0 ) }  => Prints `1`
    ///        let nilOptional: Int? = nil
    ///        nilOptional.then { print( $0 ) }  => Nothing happens
    ///
    @discardableResult
    func then<T>( _ block: ( Wrapped ) throws -> T ) rethrows -> T? {
        switch self {
        case .none: return nil
        case .some( let value ): return try block( value )
        }
    }
}
