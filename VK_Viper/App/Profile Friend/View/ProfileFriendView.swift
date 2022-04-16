//
//  ProfileFriendView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI

struct ProfileFriendView: View {
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    /// Body
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            presentor.getUserInfo()
            presentor.getListUserFriends()
        }
        .navigationTitle(presentor.userInfo?.domain ?? "")
    }
}
