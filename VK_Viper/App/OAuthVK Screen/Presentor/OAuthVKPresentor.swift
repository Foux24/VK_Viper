//
//  OAuthVKPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

// MARK: - OAuthVKPresentor
final class OAuthVKPresentor {

    /// Роутер
    private let router: OAuthVKRouterInput
    
    /// Интерактор
    private let interactor: OAuthVKInteractorInput
    
    /// WelcomeScreen ViewController
    weak var welcomeScreenViewController: WelcomeScreenViewInput?
    
    /// Инициализтор
    /// - Parameters:
    /// - router: Роутер
    /// - interactor: Интерактор
    init(router: OAuthVKRouterInput, interactor: OAuthVKInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - OAuthVKViewOutput
extension OAuthVKPresentor: OAuthVKViewOutput {

    /// Алерт при закрытии в ручную модального окна
    func getWarningAutorization() {
        welcomeScreenViewController?.showAlert(title: "Warning",
                        message: "Вы закрыли окно не авторизовавшись :(\nДля дальнейшей работы с приложением вам необходимо авторизоваться")
    }
    
    /// Загрузка экрана авторизации VK.com
    func setupWKView(with view: OAuthVKView) {
        interactor.loadScreen(with: view)
    }

    /// Закрываем экран
    func dismissScreen() {
        router.dismissScreen()
    }
}
