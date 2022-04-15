//
//  WelcomeScreenViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Входящий протокол WelcomeScreenViewController
protocol WelcomeScreenViewInput: AnyObject {

    /// Показать алерт
    ///  - Parameters:
    ///   - title: Заголовок,
    ///   - message: Сообщение
    func showAlert(title: String, message: String) -> Void
    
    /// результат проверки токена
    var resultVerificationToken: Bool { get set }
}

// MARK: - ViewController Welcome Screen
final class WelcomeScreenViewController: UIViewController {
    
    /// результат проверки токена
    var resultVerificationToken = Bool() {
        didSet {
            output?.actionAfterVerificationToken(verificationToken: resultVerificationToken)
        }
    }
    
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
        output?.verificationToken()
    }
}

// MARK: - Private
private extension WelcomeScreenViewController {
    
    /// Добавление таргета кнопке авторизации в VK
    func setTargetOAuthVKButton() {
        self.castomView.oauthVKButton.addTarget(self, action: #selector(showOAuthVKScreen), for: .touchUpInside)
    }
    
    /// Переход на экран авторизации
    @objc func showOAuthVKScreen() {
        output?.showOAuthVKScreen(welcomeScreenViewController: self)
    }
}

// MARK: - Extension WelcomeScreenViewController on the WelcomeScreenViewInput
extension WelcomeScreenViewController: WelcomeScreenViewInput {
    
    /// Показ алерта
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
