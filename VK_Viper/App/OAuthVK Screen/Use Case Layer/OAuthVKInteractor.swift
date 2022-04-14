//
//  OAuthVKInteractor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import Foundation

/// Входящий протокол Интерактора
protocol OAuthVKInteractorInput {
    /// Загрузить экран
    ///  - Parameter view: Вью авторизации
    func loadScreen(with view: OAuthVKView)
}

/// Интерактор
final class OAuthVKInteractor {
    private let service: OAuthVKServiceInput

    /// Инициализатор
    /// - Parameter service: Сервис
    init(service: OAuthVKServiceInput) {
        self.service = service
    }
}

// MARK: - Extension OAuthVKInteractor on the OAuthVKInteractorInput
extension OAuthVKInteractor: OAuthVKInteractorInput {
    
    /// Загрузить экран авторизации VK.com
    func loadScreen(with view: OAuthVKView) {
        service.loadLoginVK(completion: { request in
            view.webView.load(request)
        })
    }
}
