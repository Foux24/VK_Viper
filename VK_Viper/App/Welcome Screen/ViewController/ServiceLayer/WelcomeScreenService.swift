//
//  WelcomeScreenService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation
import PromiseKit

/// Входящий протокол сервиса
protocol WelcomeScreenServiceInput: AnyObject {
    /// Составляем URL
    func validationTokenPromisURL() -> Promise<URL>
    
    /// Делаем запрос
    /// - Parameter url: URL для запроса
    func validationTokenPromisData(_ url: URL) -> Promise<Data>
    
    /// Парсим Data по структуре TokenValid
    /// - Parameter data: Data полученная от запроса на сервер
    func validationTokenPromiseParsed(_ data: Data) -> Promise<TokenValid>
}

/// Сервис для WelcomeScreen
final class WelcomeScreenService: WelcomeScreenServiceInput {
    
    /// Первоначальный Конфигуратор URL
    private let urlConfigurator: URLConfiguratorOutput
    
    /// Декодер
    private let decoder = JSONDecoder()
    
    /// Инициалзитор
    /// - Parameter urlConfigurator: Первоначальный конфигуратор URL
    init(urlConfigurator: URLConfiguratorOutput) {
        self.urlConfigurator = urlConfigurator
    }
    
    /// Составляем URL
    func validationTokenPromisURL() -> Promise<URL> {
        let serviceToken = ServiceTokenApp()
        let token = Session.instance.dataSession.token ?? ""
        let params: [String: String] = ["token" : token]
        let urlConfig = urlConfigurator.configureUrl(token: serviceToken.serviceToken,
                                                     typeMethod: .tokenValidation,
                                                     typeRequest: .get,
                                                     params: params)
        return Promise { resolver in
            let url = urlConfig
            resolver.fulfill(url)
        }
    }
    
    /// Делаем запрос
    func validationTokenPromisData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            urlConfigurator.session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    resolver.reject(ErrorRequest.taskError)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    /// Парсим Data по структуре TokenValid
    func validationTokenPromiseParsed(_ data: Data) -> Promise<TokenValid> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JSONModelTokenValid.self, from: data).response
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
}
