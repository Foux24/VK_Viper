//
//  AllPhotoUserCollectionCell.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 19.04.2022.
//

import SwiftUI

/// AllPhotoUserCollectionCell
struct AllPhotoUserCollectionCell: View {
    
    /// URL
    let url: URL
    
    /// Image Loader
    @ObservedObject var imageLoader: ASRemoteImageLoader
    
    /// Инициализтор
    /// - Parameter url: URL изображения
    init(_ url: URL) {
        self.url = url
        imageLoader = ASRemoteImageManager.shared.imageLoader(for: url)
    }

    /// Body
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
            Image(systemName: "photo")
            self.imageLoader.image.map { image in
                Image(uiImage: image)
                    .resizable()
            }
            .transition(AnyTransition.opacity.animation(Animation.default))
        }
        .compositingGroup()
    }
}
