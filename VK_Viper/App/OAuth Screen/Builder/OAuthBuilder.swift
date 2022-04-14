//
//  OAuthBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Builder для OAuthViewController
final class OAuthBuilder {
    
    /// Билд контроллера
    static func build() -> UIViewController {
        let viewController = OAuthViewController()
        return viewController
    }
}
