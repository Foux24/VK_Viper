//
//  PhotoUserViewCollectionCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI
import Kingfisher

/// Коллекция фотографий друга
struct PhotoUserViewCollectionCell: View {
    
    /// Фото
    let photoFriend: PhotoFriendData
    
    /// Флаг выбранной фотографии
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

/// Для расчета высота ячейки
struct PhotoFriendRowHeightPreferenceKey: PreferenceKey {
    
    /// Дефолтная высота
    static var defaultValue: CGFloat = 0
    
    /// Передача новой высоты
    /// - Parameters:
    ///  - value: Значение
    ///  - nextValue: Новое значение
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
