//
//  ListMyFriendService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation
import PromiseKit

/// Входящий протокол сервиса
protocol ListMyFriendServiceInput: AnyObject {
    
    /// Составляем URL
    func listMyFriendsPromisURL(idUser: String) -> Promise<URL>
    
    /// Делаем запрос
    /// - Parameter url: URL для запроса
    func listMyFriendsPromisData(_ url: URL) -> Promise<Data>
    
    /// Парсим Data по структуре ListMyFriend
    /// - Parameter data: Data полученная от запроса на сервер
    func listMyFriendsPromiseParsed(_ data: Data) -> Promise<ListFriend>
}

/// ListMyFriendService
final class ListMyFriendService {
    
    /// Первоначальный Конфигуратор URL
    private let urlConfigurator: URLConfiguratorOutput
    
    /// Декодер
    private let decoder = JSONDecoder()
    
    /// Инициалзитор
    /// - Parameter urlConfigurator: Первоначальный конфигуратор URL
    init(urlConfigurator: URLConfiguratorOutput) {
        self.urlConfigurator = urlConfigurator
    }
}

/// extension ListMyFriendService on the ListMyFriendServiceInput
extension ListMyFriendService: ListMyFriendServiceInput {
    
    /// Составляем URL
    func listMyFriendsPromisURL(idUser: String) -> Promise<URL> {
        let token = Session.instance.dataSession.token ?? ""
        let params: [String: String] = ["user_id" : idUser,
                                        "fields" : "photo_200_orig,status"]
        let urlConfig = urlConfigurator.configureUrl(token: token,
                                                     typeMethod: .listFriends,
                                                     typeRequest: .get,
                                                     params: params)
        return Promise { resolver in
            let url = urlConfig
            print(url)
            resolver.fulfill(url)
        }
    }
    
    /// Делаем запрос
    func listMyFriendsPromisData(_ url: URL) -> Promise<Data> {
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
    
    /// Парсим Data по структуре ListMyFriend
    func listMyFriendsPromiseParsed(_ data: Data) -> Promise<ListFriend> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JSONModelListMyFriend.self, from: data).response
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
}
