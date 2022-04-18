//
//  ListMyFriendInteractor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Входящий протокол интерактора
protocol ListMyFriendInteractorInput: AnyObject {
    /// Получение списка друзей
    /// - Parameters:
    ///  - idUser: id Пользователя
    ///  - complition: Блок обработки запроса, на выходе список друзей  или ошибка
    func getListMyFriend(idUser: String, completion: @escaping (Result<[Friends], ErrorVK>) -> Void)
}

/// Интерактор для презентора  List My Friend ViewController
final class ListMyFriendInteractor {
    
    /// Сервис по загрузки данных
    private let service: ListMyFriendServiceInput
    
    /// Инициализтор
    /// - Parameter service: Сервис по запросу на сервер
    init(service: ListMyFriendServiceInput) {
        self.service = service
    }
}

/// Extension ListMyFriendInteractor on the ListMyFriendInteractor
extension ListMyFriendInteractor: ListMyFriendInteractorInput {
    
    /// Получение списка друзей
    func getListMyFriend(idUser: String, completion: @escaping (Result<[Friends], ErrorVK>) -> Void) {
        service.listMyFriendsPromisURL(idUser: idUser)
            .then(on: DispatchQueue.global(), service.listMyFriendsPromisData(_:))
            .then(service.listMyFriendsPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response.items))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
}
