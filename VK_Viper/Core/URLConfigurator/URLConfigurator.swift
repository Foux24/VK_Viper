//
//  URLConfigurator.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation

/// Выходящий протокол NetworkService
protocol URLConfiguratorOutput: AnyObject {
    
    /// Конфигуратор УРЛ
    /// - Parameters:
    ///  - token: Токен после авторийзации
    ///  - typeMethod: Метод запроса к API
    ///  - typeRequest: http метод get или post
    ///  - params: Параметры
    func configureUrl(token: String, typeMethod: TypeMethods, typeRequest: TypeRequest, params: [String: String]) -> URL
    
    /// Сессия
    var session: URLSession { get set }
}

/// Типы методов для запроса к API
enum TypeMethods: String {
    case tokenValidation = "/method/secure.checkToken"
    case listFriends = "/method/friends.get"
}

/// Типы запросов
enum TypeRequest: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - NetworkService
final class URLConfigurator: URLConfiguratorOutput {
    
    /// URLSession
    var session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    /// Протокол запроса
    private let scheme = "https"
    
    /// Адресс сервера
    private let host = "api.vk.com"
    
    /// Конфигуратор УРЛ
    func configureUrl(token: String,
                      typeMethod: TypeMethods,
                      typeRequest: TypeRequest,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.81"))
        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = typeMethod.rawValue
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        return url
    }
}
