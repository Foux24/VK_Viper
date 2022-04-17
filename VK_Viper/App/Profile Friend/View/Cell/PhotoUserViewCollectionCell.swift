//
//  PhotoUserViewCollectionCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI
import Kingfisher

struct PhotoUserViewCollectionCell: View {
    
    let photoFriend: PhotoFriendData
    
    let isSelected: Bool

    var body: some View {
        GeometryReader { proxy in
            KFImage(URL(string: photoFriend.friendPhoto))
                .resizable()
                .cancelOnDisappear(true)
                .cornerRadius(8)
                .preference(key: PhotoFriendRowHeightPreferenceKey.self, value: proxy.size.width)
        }
    }
}

struct PhotoFriendRowHeightPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
