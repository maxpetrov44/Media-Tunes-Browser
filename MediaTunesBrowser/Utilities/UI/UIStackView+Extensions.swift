//
//  UIStackView+Extensions.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
}
