//
//  WelcomeScreenViewOutput.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

/// Исходящий протокол Экрана приветствия
protocol WelcomeScreenViewOutput: AnyObject {
    
    /// Переход на экран авторизации в VK
    func showOAuthVKScreen(welcomeScreenViewController controller: UIViewController) -> Void
    
    /// Проверка валидности токена
    func verificationToken() -> Void
    
    /// Дейтсвие при проверке валидности токена
    /// - Parameter verificationToken: Результат проверки токена
    func actionAfterVerificationToken(verificationToken: Bool) -> Void
}
