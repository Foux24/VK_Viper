//
//  ListMyFriendTableViewCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit

/// Ячейка для Lisy My Friend TableView
final class ListMyFriendTableViewCell: UITableViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: ListMyFriendTableViewCell.self)
    
    /// UIImageView - аватарка
    private(set) lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.2
        return imageView
    }()
    
    /// UILabel - Имя друга
    private(set) lazy var nameFriendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UILabel - статус
    private(set) lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blackAlpha06
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Конфигурация ячейки
    func configurationCell(image: UIImage?, nameFriend: String, status: String?) -> Void {
        guard let status = status else { return }
        guard let image = image else { return }
        avatarImageView.image = image
        nameFriendLabel.text = nameFriend
        statusLabel.text = status
        addUIInView()
        setupConstreints()
    }
}

/// Private
private extension ListMyFriendTableViewCell {
    
    /// Добавление UI
    func addUIInView() -> Void {
        self.addSubview(avatarImageView)
        self.addSubview(nameFriendLabel)
        self.addSubview(statusLabel)
    }
    
    /// Раставим констрейнты
    func setupConstreints() -> Void {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameFriendLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameFriendLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: -5),
            nameFriendLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            statusLabel.leadingAnchor.constraint(equalTo: nameFriendLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
