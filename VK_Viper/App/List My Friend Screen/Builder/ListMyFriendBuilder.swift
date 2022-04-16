//
//  ListMyFriendBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Builder для ListMyFriendViewController
final class ListMyFriendBuilder {
    
    /// Build контроллера
    static func build() -> UIViewController {
        let urlConfigurator = URLConfigurator()
        let service = ListMyFriendService(urlConfigurator: urlConfigurator)
        let interactor = ListMyFriendInteractor(service: service)
        let router = ListMyFriendRouter()
        let presentor = ListMyFriendPresentor(interactor: interactor, router: router)
        let viewController = ListMyFriendViewController()
        viewController.output = presentor
        presentor.listMyFriendViewController = viewController
        router.listMyFriendViewController = viewController
        return viewController
    }
}
