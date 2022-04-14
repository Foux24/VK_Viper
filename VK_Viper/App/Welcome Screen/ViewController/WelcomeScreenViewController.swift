//
//  WelcomeScreenViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

// MARK: - ViewController Welcome Screen
final class WelcomeScreenViewController: UIViewController {
    
    /// Обработчик исходящих событий
    var output: WelcomeScreenViewOutput?
    
    /// UIView - View для Welcome Screen ViewController
    private var castomView: WelcomeScreenView {
        return self.view as! WelcomeScreenView
    }
    
    /// Life Cycle - load view
    override func loadView() {
        super.loadView()
        self.view = WelcomeScreenView()
    }
    
    /// Life Cycle - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargetOAuthVKButton()
    }
}

// MARK: - Private
private extension WelcomeScreenViewController {
    
    /// Добавление таргета кнопке
    func setTargetOAuthVKButton() {
        self.castomView.oauthVKButton.addTarget(self, action: #selector(showOAuthVKScreen), for: .touchUpInside)
    }
    
    /// Переход на экран авторизации
    @objc func showOAuthVKScreen() {
        output?.showOAuthVKScreen()
    }
}
