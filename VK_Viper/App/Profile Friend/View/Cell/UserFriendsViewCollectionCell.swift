//
//  UserFriendsViewCollectionCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI
import Kingfisher

/// Коллекция друзей друга
struct UserFriendsViewCollectionCell: View {
    
    /// Аватарка
    let avatar: String
    
    /// Имя друга
    let firstName: String
    
    /// Фамилия друга
    let lastName: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: avatar))
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .setCastomAvatarEffects()
            Text(firstName)
                .font(.system(size: 12, weight: .medium, design: .default))
                .lineLimit(1)
            Text(lastName)
                .font(.system(size: 12, weight: .medium, design: .default))
                .lineLimit(1)
        }
    }
}
