//
//  UICollectionReusableView.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

extension UICollectionReusableView {
    class var reuseIdentifier: String {
        String(describing: self)
    }
}
