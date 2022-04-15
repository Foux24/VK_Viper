//
//  WelcomeScreenPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Presentor для WelcomeScreenViewController
final class WelcomeScreenPresentor {
    
    /// Router
    private let router: WelcomeScreenRouterInput
    
    /// Interactor
    private let interactor: WelcomeScreenInteractorInput
    
    /// WelcomeScreen
    weak var welcomeScreenView: WelcomeScreenViewInput?
    
    /// Инициализтор
    ///  - Parameters:
    ///   - router: Router
    ///   - interactor: Interactor
    init(router: WelcomeScreenRouterInput, interactor: WelcomeScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

/// Extension WelcomeScreenPresentor on the WelcomeScreenViewOutput
extension WelcomeScreenPresentor: WelcomeScreenViewOutput {
    /// Проверка токена на валидность
    func verificationToken() {
        interactor.validationToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tokenValid):
                if tokenValid.success == 1 {
                    self.welcomeScreenView?.resultVerificationToken = true
                } else {
                    self.welcomeScreenView?.resultVerificationToken = false
                    self.showAlertFalseVerificationToken()
                }
            case .failure(let error):
                self.welcomeScreenView?.showAlert(title: "Error code \(error.errorCode)", message: error.errorMsg)
            }
        }
    }
    
    /// Переход на экран авторизации в VK
    func showOAuthVKScreen(welcomeScreenViewController controller: UIViewController) {
        router.showOAuthVKScreen(welcomeScreenViewController: controller)
    }
    
    /// Очистка данных сессии и  вовод алерта при просроченном токене
    func showAlertFalseVerificationToken() {
        Session.instance.cleanSession()
        welcomeScreenView?.showAlert(title: "Token", message: "Истек срок действия вашего токена, пожалуйста авторизайтесь снова")
    }
}
