//
//  WelcomeScreenRouter.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Входящий протокол роутера
protocol WelcomeScreenRouterInput: AnyObject {
    
    /// Переход на экран авторизации в VK
    func showOAuthVKScreen() -> Void
}

/// Router для Welcome Screen ViewController
final class WelcomeScreenRouter {
    
    /// ссылка на welcomeScreenViewController
    weak var welcomeScreenViewController: UIViewController?
}

/// Extension WelcomeScreenRouter on the WelcomeScreenRouterInput
extension WelcomeScreenRouter: WelcomeScreenRouterInput {
    
    /// Переход на экран авторизации
    func showOAuthVKScreen() -> Void {
        let vc = OAuthVKBuilder.build()
        self.welcomeScreenViewController?.navigationController?.showDetailViewController(vc, sender: self)
    }
}
