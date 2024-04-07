//
//  UICollectionView+Extension.swift
//  MediaTunesBrowser
//
//  Created by Maksim Petrov on 07.04.2024.
//

import UIKit

extension UICollectionView {
    func registerCellClass(_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeueCell<CellType: UICollectionViewCell>(_ cellClass: CellType.Type, for indexPath: IndexPath) -> CellType {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier,
                                                  for: indexPath) as? CellType
            else { fatalError("\(cellClass) was not resolved.") }
        
        return cell
    }
}
