//
//  AllPhotoUserVIew.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 19.04.2022.
//

import SwiftUI
import ASCollectionView
import MagazineLayout

/// AllPhotoUserVIew
struct AllPhotoUserVIew: View {
    
    /// Массив фотографий пользовталея
    @State private(set) var arrayURLPhoto: [PhotoFriendData] = []
    
    /// AS Manager
    let imageManager = ASRemoteImageManager.shared
    
    /// Body
    var body: some View {
        ASCollectionView(data: arrayURLPhoto) { photo, _ in
            let url = URL(string: photo.friendPhoto)
            AllPhotoUserCollectionCell(url!)
                .aspectRatio(1, contentMode: .fit)
                .onAppear {
                    imageManager.load(url!)
                }
                .onDisappear {
                    imageManager.cancelLoad(for: url!)
                }
        }
        .layout { MagazineLayout() }
        .customDelegate(ASCollectionAllPhotoUserDelegate.init)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Фото пользователя", displayMode: .inline)
    }
}
