//
//  PhotoUserView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI

struct PhotoUserView: View {
    
    
    @State private var rowHeight: CGFloat? = nil
    
    @State private var selectedRow: Int? = nil
    
    @Namespace var namespace
    
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity))
    ]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhotoUserView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUserView()
    }
}
