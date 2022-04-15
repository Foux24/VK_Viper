//
//  WelcomeScreenInteractor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Входной протокол Интерактора
protocol WelcomeScreenInteractorInput {
    /// Проверка валидности токена
    /// - Parameter complition: Блок обработки запроса, на выходе результат проверки или ошибка
    func validationToken(completion: @escaping (Result<TokenValid, ErrorVK>) -> Void)
}

/// Интератор для Welcome Screen
final class WelcomeScreenInteractor: WelcomeScreenInteractorInput {

    /// Сервис по загрузки данных
    private let service: WelcomeScreenServiceInput
    
    /// Инициализтор
    /// - Parameter service: Сервис по запросу на сервер
    init(service: WelcomeScreenServiceInput) {
        self.service = service
    }
    
    /// Проверка валдиности тококена
    func validationToken(completion: @escaping (Result<TokenValid, ErrorVK>) -> Void) {
        if Session.instance.dataSession.token != nil {
            service.validationTokenPromisURL()
                .then(on: DispatchQueue.global(), service.validationTokenPromisData(_:))
                .then(service.validationTokenPromiseParsed(_:))
                .done(on: DispatchQueue.main) { response in
                    completion(.success(response))
                }.catch { error in
                    completion(.failure(error as! ErrorVK))
                }
        }
    }
}
