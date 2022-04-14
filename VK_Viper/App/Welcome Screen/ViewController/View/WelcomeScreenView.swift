//
//  WelcomeScreenView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// View для Welcome Screen ViewController
final class WelcomeScreenView: UIView {
    
    /// UIView - Контейнер для HeaderLabel
    private(set) lazy var container: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 3.0
        view.layer.shadowRadius = 6.0
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.backgroundColor = .blackAlpha06
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.4
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// UILabel - Лейбл с заголовком
    private(set) lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "VK Client\nПод архитектуру VIPER"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UIButton  - Кнопка для авторизация в VK
    private(set) lazy var oauthVKButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход через VK", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

/// Private для WelcomeScreenView
private extension WelcomeScreenView {
    
    /// Настройка View
    func setupView() -> Void {
        self.backgroundColor = .white
    }
    
    /// Добавление UI
    func addUIInView() -> Void {
        self.addSubview(container)
        self.container.addSubview(headerLabel)
        self.addSubview(oauthVKButton)
    }
    
    /// Раставим констрейнты
    func setupConstreints() -> Void {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            headerLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            headerLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            
            oauthVKButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            oauthVKButton.heightAnchor.constraint(equalToConstant: 40),
            oauthVKButton.widthAnchor.constraint(equalToConstant: 250),
            oauthVKButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
