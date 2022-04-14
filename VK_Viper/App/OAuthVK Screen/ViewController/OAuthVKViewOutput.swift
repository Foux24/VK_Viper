//
//  OAuthVKViewOutput.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

/// Исходящий протокол контроллера авторизации
protocol OAuthVKViewOutput {
    
    /// Алерт при закрытии в ручную модального окна
    func getWarningAutorization()
    
    /// Скрыть экран
    func dismissScreen()

    /// Загрузка экрана авторизации VK.com
    ///  - Parameter view: Вьюха авторизации
    func setupWKView(with view: OAuthVKView)
}
