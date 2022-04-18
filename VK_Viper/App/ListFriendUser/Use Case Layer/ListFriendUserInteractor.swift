//
//  ListFriendUserInteractor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import SwiftUI
import Combine

/// Входящий протокол интерактора
protocol ListFriendUserInteractorInput: AnyObject {
    /// Получение списка друзей пользователя
    /// - Parameters:
    ///  - idUser: ID Пользователя
    ///  - complition: Блок результат которого список друзей или ошибка
    func getListFriendUser(idUser: String, complition: @escaping (Result<[Friends], Error>) -> Void)
}

/// Интерактор для ListFriendUserPresentor
final class ListFriendUserInteractor {
    
    /// AnyCancellabel для запроса в сеть
    private var listUserFriendRequest: AnyCancellable?
    
    /// Сервис по загрузки данных
    private let service: ListFriendUserServiceInput
    
    /// Инициализтор
    /// - Parameter service: Сервис по запросу на сервер
    init(service: ListFriendUserServiceInput) {
        self.service = service
    }
}

/// Extension ListFriendUserInteractor on the ListFriendUserInteractorInput
extension ListFriendUserInteractor: ListFriendUserInteractorInput {
    
    /// Получение списка друзей пользователя
    func getListFriendUser(idUser: String, complition: @escaping (Result<[Friends], Error>) -> Void) {
        self.listUserFriendRequest = service.getListFriendUser(idUser: idUser)
            .sink { result in
                switch result {
                case.failure(let error):
                    complition(.failure(error))
                case.finished:
                    break
                }
            } receiveValue: { friend in
                complition(.success(friend))
            }
    }
}
