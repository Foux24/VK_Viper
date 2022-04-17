//
//  UserFriendsView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI
import ASCollectionView

/// Друзья друга
struct UserFriendsView: View {
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 5) {
                Text("ДРУЗЬЯ")
                    .font(.system(size: 14, weight: .medium, design: .default))
                Text("\(presentor.userFriend.count)")
                    .font(.system(size: 14, weight: .light, design: .default))
                    .foregroundColor(Color.gray)
                Circle()
                    .scaleEffect(1)
                    .foregroundColor(Color.gray)
                    .frame(width: 2, height: 2)
                Text("\(presentor.userInfo?.commonCount ?? 0) общих")
                    .font(.system(size: 14, weight: .light, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding(.leading, 15.0)
            ASCollectionView(data: presentor.userFriend) { friend, _ in
                UserFriendsViewCollectionCell(avatar: friend.photo200_Orig,
                                              firstName: friend.firstName,
                                              lastName: friend.lastName)
                .scaleEffect(0.9)
            }
            .layout(scrollDirection: .horizontal) {
                .list(
                    itemSize: .absolute(80),
                    sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            //        .frame(height: 130)
        }
    }
}
