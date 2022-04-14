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
    static func build() -> UIViewController {
        let viewController = OAuthVKViewController()
        return viewController
    }
}
