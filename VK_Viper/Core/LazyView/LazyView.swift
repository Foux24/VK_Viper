//
//  LazyView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import SwiftUI

/// LazyView
struct LazyView<Content: View>: View {
    
    /// Контент
    private let content: () -> Content
    
    /// Инициализтор
    /// - Parameter countent: Countent View
    init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }
    
    /// Body
    var body: some View {
        self.content()
    }
}
