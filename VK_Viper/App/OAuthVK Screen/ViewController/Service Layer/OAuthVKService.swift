//
//  OAuthVKService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import Foundation

/// Входящий протокол сервиса
protocol OAuthVKServiceInput {

    /// Загрузить данные webView
    ///  - Parameter completion: Блок, обрабатывающий выполнение запроса
    func loadLoginVK(completion: @escaping (URLRequest) -> Void)
}

/// Сервис для экрана авторизации
final class OAuthVKService: OAuthVKServiceInput {

    /// Загрузить данные c webView
    func loadLoginVK(completion: @escaping (URLRequest) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8002071"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html" ),
            URLQueryItem(name: "scope", value: "photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        completion(request)
    }
}
