//
//  ProfileFriendInteractor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit

/// Входящий протокол интерактора
protocol ProfileFriendInteractorInput: AnyObject {
    /// Получение информации о друге
    /// - Parameters:
    ///  - idFriend: Id друга
    ///  - complition: Блок обработки запроса, на выходе информация  или ошибка
    func getUserInfo(idFriend: String, completion: @escaping (Result<[UserInfo], ErrorVK>) -> Void)
    
    /// Получение списка друзей
    /// - Parameters:
    ///  - idFriend: Id друга
    ///  - complition: Блок обработки запроса, на выходе список друзей  или ошибка
    func getListFriend(idFriend: String, completion: @escaping (Result<[Friends], ErrorVK>) -> Void)
    
    /// Получение списка фотографий пользователя
    /// - Parameters:
    ///  - idFriend: Id пользователя
    ///  - complition: Блок обработки запроса, на выходе список фото  или ошибка
    func getAllUserPhoto(idFriend: String, completion: @escaping (Result<[PhotoUser], ErrorVK>) -> Void)
}

/// Интерактор для презентора  Profile Friend View
final class ProfileFriendInteractor {
    
    /// Сервис по загрузки данных
    private let service: ProfileFriendServiceInput
    
    /// Инициализтор
    /// - Parameter service: Сервис по запросу на сервер
    init(service: ProfileFriendServiceInput) {
        self.service = service
    }
}

/// Extension ProfileFriendInteractor on the ListMyFriendInteractorInput
extension ProfileFriendInteractor: ProfileFriendInteractorInput {
    
    /// Получение информации о друге
    func getUserInfo(idFriend: String, completion: @escaping (Result<[UserInfo], ErrorVK>) -> Void) {
        service.userInfoPromisURL(idFriend: idFriend)
            .then(on: DispatchQueue.global(), service.userInfoPromisData(_:))
            .then(service.userInfoPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
    
    /// Получение списка друзей
    func getListFriend(idFriend: String, completion: @escaping (Result<[Friends], ErrorVK>) -> Void) {
        service.listUserFriendPromisURL(idFriend: idFriend)
            .then(on: DispatchQueue.global(), service.listUserFriendPromisData(_:))
            .then(service.listUserFriendPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response.items))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
    
    /// Получение коллекции фотографий друга
    func getAllUserPhoto(idFriend: String, completion: @escaping (Result<[PhotoUser], ErrorVK>) -> Void) {
        service.UserPhotoPromisURL(idFriend: idFriend)
            .then(on: DispatchQueue.global(), service.UserPhotoPromisData(_:))
            .then(service.UserPhotoPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
}
