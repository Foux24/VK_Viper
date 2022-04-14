//
//  WelcomeScreenViewOutput.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

/// Исходящий протокол Экрана приветствия
protocol WelcomeScreenViewOutput: AnyObject {
    
    /// Переход на экран авторизации в VK
    func showOAuthVKScreen() -> Void
}