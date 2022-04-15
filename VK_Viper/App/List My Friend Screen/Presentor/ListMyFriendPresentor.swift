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
    
    init(interactor: ListMyFriendInteractorInput) {
        self.interactor = interactor
    }
}

/// Extension ListMyFriendPresentor on the ListMyFriendViewControllerOutput
extension ListMyFriendPresentor: ListMyFriendViewControllerOutput {
    
    /// Получение списка друзей
    func getListFriends() {
        interactor.getListMyFriend { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listFriends):
                print(listFriends)
            case .failure(let error):
                print(error)
            }
        }
    }
}
