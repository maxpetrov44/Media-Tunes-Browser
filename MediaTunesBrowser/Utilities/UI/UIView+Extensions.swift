//
//  UIView+Extensions.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue!.resolvedColor(with: self.traitCollection).cgColor
        }
    }
    
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.shadowColor = newValue!.cgColor }
    }
    
    public var shadowOffsetHeight: CGFloat {
        get { layer.shadowOffset.height }
        set { layer.shadowOffset.height = newValue }
    }
    
    public var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    public var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
}
