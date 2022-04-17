//
//  ListMyFriendRouter.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit

/// Входящий протокол Роутера
protocol ListMyFriendRouterInput: AnyObject {
    /// Переход в профиль друга
    /// - Parameter dataFriend: Общие Данные друга
    func showProfileFriend(dataFriend: Friends) -> Void
}

/// Router для List My Friend Presentor
final class ListMyFriendRouter {
    
    /// ListMyFriendViewController
    weak var listMyFriendViewController: UIViewController?

}

/// Extension ListMyFriendRouter on the ListMyFriendRouterInput
extension ListMyFriendRouter: ListMyFriendRouterInput {
    
    /// Переход в профиль друга
    func showProfileFriend(dataFriend: Friends) -> Void {
        self.listMyFriendViewController?.navigationController?.pushViewController(ProfileFriendBuilder.Build(idUser: dataFriend.id), animated: true)
    }
}
