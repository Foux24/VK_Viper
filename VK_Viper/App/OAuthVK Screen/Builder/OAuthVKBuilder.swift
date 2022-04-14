//
//  OAuthVKBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Builder для OAuthVKViewController
final class OAuthVKBuilder {
    
    /// Билд контроллера
    /// - Parameter welcomeScreenViewController: Контроллер экрана приветствия
    static func build(welcomeScreenViewController controller: UIViewController) -> UIViewController {
        let service = OAuthVKService()
        let router = OAuthVKRouter()
        let interactor = OAuthVKInteractor(service: service)
        let presentor = OAuthVKPresentor(router: router, interactor: interactor)
        let viewController = OAuthVKViewController()
        router.viewController = viewController
        router.welcomeScreenViewController = controller
        presentor.welcomeScreenViewController = controller as? WelcomeScreenViewInput
        viewController.output = presentor
        return viewController
    }
}
