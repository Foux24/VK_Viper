//
//  Extension+UICollectionViewCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Extension UICollectionViewCell on the Reusable
extension UICollectionViewCell: Reusable {}

/// Extension Reusable on the UICollectionViewCell
extension Reusable where Self: UICollectionViewCell {
    
    /// ReuseID
    static var reuseID: String {
        return String(describing: self)
    }
}

/// Extension UICollectionView
extension UICollectionView {
    
    /// Регистрация ячейки
    /// - Parameter cellClass: Передаем тип ячейки
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseID)
    }
    
    /// Приводим ячйку к типу
    /// - Parameter indexPath: Индекс ячейки
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }
        return cell
    }
}
