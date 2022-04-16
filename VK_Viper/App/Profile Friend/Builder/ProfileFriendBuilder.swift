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
    static func Build(dataFriend: Friends) -> UIViewController {
        let urlConfigurator = URLConfigurator()
        let service = ProfileFriendService(urlConfigurator: urlConfigurator)
        let interactor = ProfileFriendInteractor(service: service)
        let profileFriendPresentor = ProfileFriendPresentor(dataFriend: dataFriend, interactor: interactor)
        let profileFriendView = UIHostingController(rootView: ProfileFriendView(presentor: profileFriendPresentor))
        return profileFriendView
    }
}
