//
//  ListMyFriendViewControllerOutput.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

/// Исходящий протокол экрана со списком друзей
protocol ListMyFriendViewControllerOutput: AnyObject {
    
    /// Получение списка друзей
    func getListFriends() -> Void
    
    /// Переход в профиль друга
    func showProfileFriend(dataFriend: Friends) -> Void
}
