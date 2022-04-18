//
//  ListFriendUserPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import SwiftUI
import Combine

/// Presentor для ListFriendView
final class ListFriendUserPresentor: ObservableObject {
    
    /// id пользователя
    var idUser: Int
    
    /// Список друзей филтрованных на словарь
    @Published private(set) var arrayFriend: [FriendSection] = []
    
    /// Interactor
    private let interactor: ListFriendUserInteractorInput

    /// Инициализтор
    /// - Parameters:
    ///  - idUser: idUser
    ///  - interactor: Interactor
    init(idUser: Int, interactor: ListFriendUserInteractorInput) {
        self.idUser = idUser
        self.interactor = interactor
    }
    
    /// Получение списка друзей и их соритровка по FriendSection
    func getListFriendUser() -> Void {
        interactor.getListFriendUser(idUser: String(idUser)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.arrayFriend = self.formFriendArray(from: friends)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Переход на профиль пользователя
    /// - Parameter idUser: ID пользователя
    func showFriendProfileView(idUser: Int) -> some View {
        let urlConfigurator = URLConfigurator()
        let service = ProfileFriendService(urlConfigurator: urlConfigurator)
        let interactor = ProfileFriendInteractor(service: service)
        let profileFriendPresentor = ProfileFriendPresentor(idUser: idUser, interactor: interactor)
        let profileView = ProfileFriendView(presentor: profileFriendPresentor)
        return profileView
    }
}

/// Private
private extension ListFriendUserPresentor {
    
    /// Сортировка в Словарь
    /// - Parameter array: Массив друзей полученый с сервера
    /// На выходе словрь, ключ первая буква имени, значение массив друзей у кого первая буква ключ
    func sortFriends(_ array: [Friends]) -> [Character: [Friends]] {
        var newArray: [Character: [Friends]] = [:]
        for user in array {
            guard let firstChar = user.firstName.first else { continue }
            guard var array = newArray[firstChar] else { let newValue = [user]
                newArray.updateValue(newValue, forKey: firstChar)
                continue
            }
            array.append(user)
            newArray.updateValue(array, forKey: firstChar)
        }
        return newArray
    }
    
    /// Перезаписываем словарь
    /// - Parameter dictionary: Словарь друзей
    /// На выходе массив с типом FriendSection
    func formFriendSection(_ dictionary: [Character: [Friends]]) -> [FriendSection] {
        var sectionArray: [FriendSection] = []
        for (key, array) in dictionary {
            sectionArray.append(FriendSection(key: key, data: array))
        }
        sectionArray.sort {$0 < $1}
        return sectionArray
    }
    
    /// сортируем друзей
    /// - Parameter array: Массив друзей полученый с сервера
    /// На выходе массив с типом FriendSection
    func formFriendArray(from array: [Friends]) -> [FriendSection] {
        let sortDictionary = sortFriends(array)
        let sortArray = formFriendSection(sortDictionary)
        return sortArray
    }
}
