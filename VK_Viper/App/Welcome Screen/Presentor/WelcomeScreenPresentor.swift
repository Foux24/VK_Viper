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
    private var router: WelcomeScreenRouterInput
    
    /// Инициализтор
    ///  - Parameters
    ///  - router: Router
    init(router: WelcomeScreenRouterInput) {
        self.router = router
    }
}

/// Extension WelcomeScreenPresentor on the WelcomeScreenViewOutput
extension WelcomeScreenPresentor: WelcomeScreenViewOutput {
    
    /// Переход на экран авторизации в VK
    func showOAuthVKScreen(welcomeScreenViewController controller: UIViewController) {
        router.showOAuthVKScreen(welcomeScreenViewController: controller)
    }
}
