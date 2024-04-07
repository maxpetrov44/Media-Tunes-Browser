//
//  UIView+Constraints.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

public protocol LayoutGuideProtocol {
    
    var owningView: UIView? { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: LayoutGuideProtocol {}
extension UIView: LayoutGuideProtocol {
    public var owningView: UIView? { return superview }
}

extension LayoutGuideProtocol {
    @discardableResult
    func constrainHorizontallyToSuperview(
        inset: CGFloat = 0,
        constrainToMargins: Bool = false
    ) -> [ NSLayoutConstraint ] {
        
        let secondItem: LayoutGuideProtocol = constrainToMargins
        ? owningView!.layoutMarginsGuide
        : owningView!
        
        let constraints = [
            leadingAnchor.constraint(equalTo: secondItem.leadingAnchor, constant: inset),
            secondItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset)
        ]
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainVerticallyToSuperview(
        inset: CGFloat = 0,
        constrainToMargins: Bool = false
    ) -> [ NSLayoutConstraint ] {
        
        let secondItem: LayoutGuideProtocol = constrainToMargins
        ? owningView!.layoutMarginsGuide
        : owningView!
        
        let constraints = [
            topAnchor.constraint(equalTo: secondItem.topAnchor, constant: inset),
            secondItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset),
        ]
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainVerticallyToSuperviewSafeAreaGuides(
        inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        
        let constraints = [
            topAnchor.constraint(equalTo: owningView!.safeAreaLayoutGuide.topAnchor, constant: inset),
            owningView!.safeAreaLayoutGuide.bottomAnchor.constraint( equalTo: bottomAnchor, constant: inset ),
        ]
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainToSuperview(
        insets: UIEdgeInsets = .zero,
        constrainToMargins: Bool = false
    ) -> [ NSLayoutConstraint ] {
        
        let secondItem: LayoutGuideProtocol = constrainToMargins
        ? owningView!.layoutMarginsGuide
        : owningView!
        
        let constraints = [
            topAnchor.constraint(equalTo: secondItem.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: secondItem.leadingAnchor, constant: insets.left),
            secondItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            secondItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
        ]
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func centerInSuperview(
        priority: UILayoutPriority = .required
    ) -> [ NSLayoutConstraint ] {
        return [
            centerHorizontallyInSuperview( priority: priority ),
            centerVerticallyInSuperview( priority: priority )
        ]
    }
    
    @discardableResult
    func centerHorizontallyInSuperview( 
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return centerHorizontallyWithView(
            owningView!,
            constant: constant,
            priority: priority
        )
    }
    
    @discardableResult
    func centerHorizontallyWithView( 
        _ view: LayoutGuideProtocol,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        
        let constraint = centerXAnchor.constraint(
            equalTo: view.centerXAnchor,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func centerVerticallyInSuperview( 
        _ constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint    {
        return centerVerticallyWithView( 
            owningView!,
            constant: constant,
            priority: priority
        )
    }
    
    @discardableResult func centerVerticallyWithView( 
        _ view: LayoutGuideProtocol,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint    {

        let constraint = centerYAnchor.constraint( 
            equalTo: view.centerYAnchor,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainAspectRatioTo( 
        _ multiplier: CGFloat,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint( 
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: multiplier,
            constant: constant
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainTo( 
        width: CGFloat,
        relatedBy: NSLayoutConstraint.Relation? = nil
    ) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint( 
            item: self,
            attribute: .width,
            relatedBy: relatedBy ?? .equal,
            toItem: nil, 
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainTo( 
        height: CGFloat,
        relatedBy: NSLayoutConstraint.Relation? = nil
    ) -> NSLayoutConstraint    {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: relatedBy ?? .equal,
            toItem: nil, 
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func constrainTo( 
        size: CGSize
    ) -> [ NSLayoutConstraint ] {
        return [ 
            constrainTo(width: size.width),
            constrainTo(height: size.height)
        ]
    }
}
