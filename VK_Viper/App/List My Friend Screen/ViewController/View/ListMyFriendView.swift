//
//  ListMyFriendView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit

/// View для List My Friend ViewController
final class ListMyFriendView: UIView {
    
    /// UITableView
    private(set) lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = 70
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    /// Инициализтор
    ///  - Parameter frame: frame View
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.addUIInView()
        self.setupConstreints()
    }

    ///  - Parameter aDecoder: aDecoder View
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

/// Private для ListMyFriendView
private extension ListMyFriendView {
    
    /// Настройка View
    func setupView() -> Void {
        self.backgroundColor = .white
    }
    
    /// Добавление UI
    func addUIInView() -> Void {
        self.addSubview(tableView)
    }
    
    /// Раставим констрейнты
    func setupConstreints() -> Void {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
