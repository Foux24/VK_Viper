//
//  OAuthVKRouter.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Входящий протокол роутера
protocol OAuthVKRouterInput {
    
    /// Скрыть экран авторизации
    func dismissScreen()
}

/// Роутер OAuthVKViewControlle
final class OAuthVKRouter {

    /// ссылка на OAuthVKViewController
    weak var viewController: UIViewController?

    /// Ссылка на WelcomeScreenViewController
    weak var welcomeScreenViewController: UIViewController?
    
}

/// Extension OAuthVKRouter on the OAuthVKRouterInput
extension OAuthVKRouter: OAuthVKRouterInput {
    
    /// Переход на TabBarController
    func dismissScreen() {
        viewController?.dismiss(animated: true, completion: {})
    }
}
