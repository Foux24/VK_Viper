//
//  ProfileFriendService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import Foundation
import PromiseKit

/// Входящий протокол сервиса
protocol ProfileFriendServiceInput: AnyObject {
    
    /// Составляем URL
    /// - Parameter idFriend: id user
    func userInfoPromisURL(idFriend: String) -> Promise<URL>
    
    /// Делаем запрос
    /// - Parameter url: URL для запроса
    func userInfoPromisData(_ url: URL) -> Promise<Data>
    
    /// Парсим Data по структуре UserInfo
    /// - Parameter data: Data полученная от запроса на сервер
    func userInfoPromiseParsed(_ data: Data) -> Promise<[UserInfo]>
    
    /// Составляем URL
    /// - Parameter idFriend: id user
    func listUserFriendPromisURL(idFriend: String) -> Promise<URL>
    
    /// Делаем запрос
    /// - Parameter url: URL для запроса
    func listUserFriendPromisData(_ url: URL) -> Promise<Data>
    
    /// Парсим Data по структуре ListFriend
    /// - Parameter data: Data полученная от запроса на сервер
    func listUserFriendPromiseParsed(_ data: Data) -> Promise<ListFriend>
    
    /// Составляем URL
    /// - Parameter idFriend: id user
    func UserPhotoPromisURL(idFriend: String) -> Promise<URL>
    
    /// Делаем запрос
    /// - Parameter url: URL для запроса
    func UserPhotoPromisData(_ url: URL) -> Promise<Data>
    
    /// Парсим Data по структуре ListFriend
    /// - Parameter data: Data полученная от запроса на сервер
    func UserPhotoPromiseParsed(_ data: Data) -> Promise<[PhotoUser]>
}

/// ProfileFriendService
final class ProfileFriendService {
    
    /// Первоначальный Конфигуратор URL
    private let urlConfigurator: URLConfiguratorOutput
    
    /// Декодер
    private let decoder = JSONDecoder()
    
    /// Token
    private let token = Session.instance.dataSession.token ?? ""
    
    /// Инициалзитор
    /// - Parameter urlConfigurator: Первоначальный конфигуратор URL
    init(urlConfigurator: URLConfiguratorOutput) {
        self.urlConfigurator = urlConfigurator
    }
}

/// Extension ProfileFriendService on the ProfileFriendServiceInput
extension ProfileFriendService: ProfileFriendServiceInput {

    // MARK: - UserInfo
    /// Составляем URL
    func userInfoPromisURL(idFriend: String) -> Promise<URL> {
        let params: [String: String] = ["user_ids": idFriend,
                                        "fields" : "bdate,common_count,connections,city,domain,education,exports,followers_count,friend_status,photo_200_orig,status,is_friend,timezone,last_seen,occupation"]
        let urlConfig = urlConfigurator.configureUrl(token: self.token,
                                                     typeMethod: .userInfo,
                                                     typeRequest: .get,
                                                     params: params)
        return Promise { resolver in
            let url = urlConfig
            print(url)
            resolver.fulfill(url)
        }
    }
    
    /// Делаем запрос
    func userInfoPromisData(_ url: URL) -> Promise<Data> {
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
    
    /// Парсим Data по структуре UserInfo
    func userInfoPromiseParsed(_ data: Data) -> Promise<[UserInfo]> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JSONModelProfileFriend.self, from: data)
                resolver.fulfill(response.response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
    
    // MARK: - ListFriend
    /// Составляем URL
    func listUserFriendPromisURL(idFriend: String) -> Promise<URL> {
        let params: [String: String] = ["user_id" : idFriend,
            "fields" : "photo_200_orig,status,domain,last_seen"]
        let urlConfig = urlConfigurator.configureUrl(token: self.token,
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
    func listUserFriendPromisData(_ url: URL) -> Promise<Data> {
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
    
    /// Парсим Data по структуре ListFriend
    func listUserFriendPromiseParsed(_ data: Data) -> Promise<ListFriend> {
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
    
    // MARK: - Collection User Photo
    /// Составляем URL
    func UserPhotoPromisURL(idFriend: String) -> Promise<URL> {
        let params: [String: String] = ["owner_id" : idFriend,
                                        "extended" : "1",
                                        "count" : "200"
        ]
        let urlConfig = urlConfigurator.configureUrl(token: self.token,
                                                     typeMethod: .getAllPhotoUser,
                                                     typeRequest: .get,
                                                     params: params)
        return Promise { resolver in
            let url = urlConfig
            print(url)
            resolver.fulfill(url)
        }
    }
    /// Делаем запрос
    func UserPhotoPromisData(_ url: URL) -> Promise<Data> {
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
    
    /// Парсим Data по структуре PhotoUser
    func UserPhotoPromiseParsed(_ data: Data) -> Promise<[PhotoUser]> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JSONModelPhotoUser.self, from: data).response.items
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
}
