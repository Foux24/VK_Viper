//
//  ProfileFriendBuilder.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit
import SwiftUI

/// Builder для ProfileFriendView
final class ProfileFriendBuilder {
    
    /// Build
    /// - Parameter dataFriend: Общие данные друга
    static func Build(idUser: Int) -> UIViewController {
        let urlConfigurator = URLConfigurator()
        let service = ProfileFriendService(urlConfigurator: urlConfigurator)
        let interactor = ProfileFriendInteractor(service: service)
        let profileFriendPresentor = ProfileFriendPresentor(idUser: idUser, interactor: interactor)
        let profileFriendView = UIHostingController(rootView: ProfileFriendView(presentor: profileFriendPresentor))
        return profileFriendView
    }
}
