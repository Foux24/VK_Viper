//
//  Extension+UITableViewCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Протокол Reusable
protocol Reusable{}

/// Extension UITableViewCell on the Reusable
extension UITableViewCell: Reusable {}

/// extension Reusable on the UITableViewCell
extension Reusable where Self: UITableViewCell {
    
    /// reuseID
    static var reuseID: String {
        return String(describing: self)
    }
}

/// Extension UITableView
extension UITableView {
    
    /// Регистрация чейки
    /// - Parameter cellClass: Передаем тип ячейки
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseID)
    }
    
    /// Приводим ячйку к типу
    /// - Parameter indexPath: Индекс ячейки
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else { fatalError("Fatal error for cell at \(indexPath))") }
        return cell
    }
}
