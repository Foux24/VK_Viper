//
//  SetAvatarFriend.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI

// MARK: - Модицикаторы
/// SetAvatarFriend
struct SetAvatarFriend: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80, height: 80)
            .cornerRadius(50)
            .shadow(color: Color.black, radius: 5)
    }
}

extension View {
    /// Радиус аватарок
    func setCastomAvatarEffects() -> some View {
        self
            .modifier(SetAvatarFriend())
    }
}
