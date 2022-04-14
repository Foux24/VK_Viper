//
//  WelcomeScreenBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Builder для View Controller Welcome Screen
final class WelcomeScreenBuilder {
    
    /// Билд контроллера
    static func build() -> UIViewController {
        let router = WelcomeScreenRouter()
        let presentor = WelcomeScreenPresentor(router: router)
        let viewController = WelcomeScreenViewController()
        router.welcomeScreenViewController = viewController
        viewController.output = presentor
        return viewController
    }
}
