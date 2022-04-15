//
//  ListMyFriendBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

final class ListMyFriendBuilder {
    
    static func build() -> UIViewController {
        let urlConfigurator = URLConfigurator()
        let service = ListMyFriendService(urlConfigurator: urlConfigurator)
        let interactor = ListMyFriendInteractor(service: service)
        let presentor = ListMyFriendPresentor(interactor: interactor)
        let viewController = ListMyFriendViewController()
        viewController.output = presentor
        return viewController
    }
}
