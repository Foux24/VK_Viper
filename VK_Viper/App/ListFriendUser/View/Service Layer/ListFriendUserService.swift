//
//  ListFriendUserService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import Foundation
import SwiftUI
import Combine

/// Входящий протокол сервиса
protocol ListFriendUserServiceInput: AnyObject {
    
    /// Получение списка друзей пользователя
    /// - Parameter idUser: idUser
    func getListFriendUser(idUser: String) -> AnyPublisher<[Friends], Error>
}

/// Service Layer on ListFriendUser
final class ListFriendUserService {
    
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

/// Extension ListFriendUserService on the ListFriendUserServiceInput
extension ListFriendUserService: ListFriendUserServiceInput {
    
    /// Получение списка друзей пользователя
    func getListFriendUser(idUser: String) -> AnyPublisher<[Friends], Error> {
        
        let params: [String: String] = ["user_id" : idUser,
                                        "fields" : "photo_200_orig,status"]
        let url = urlConfigurator.configureUrl(token: token,
                                               typeMethod: .listFriends,
                                               typeRequest: .get,
                                               params: params)
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map {
                return $0.data
            }
            .decode(type: JSONModelListMyFriend.self, decoder: decoder)
            .map { $0.response.items }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
