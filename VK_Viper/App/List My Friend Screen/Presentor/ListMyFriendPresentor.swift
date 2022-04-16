//
//  ListMyFriendPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Presentor для List My Friend ViewController
final class ListMyFriendPresentor {
    
    /// Ineractor
    private let interactor: ListMyFriendInteractorInput
    
    /// Router
    private let router: ListMyFriendRouterInput
    
    /// List My Friend ViewController
    weak var listMyFriendViewController: ListMyFriendViewControllerInput?
    
    init(interactor: ListMyFriendInteractorInput, router: ListMyFriendRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

/// Extension ListMyFriendPresentor on the ListMyFriendViewControllerOutput
extension ListMyFriendPresentor: ListMyFriendViewControllerOutput {
    
    /// Получение списка друзей
    func getListFriends() {
        interactor.getListMyFriend { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let myFriend):
                self.listMyFriendViewController?.listMyFriend = self.formFriendArray(from: myFriend)
            case .failure(let error):
                self.listMyFriendViewController?.showAlert(title: "Error code\(error.errorCode)", message: error.errorMsg)
            }
        }
    }
    
    /// Переход в профиль друга
    func showProfileFriend(dataFriend: Friends) -> Void {
        router.showProfileFriend(dataFriend: dataFriend)
    }
}

private extension ListMyFriendPresentor {
    
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
