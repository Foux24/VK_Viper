//
//  ListFriendUserView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import SwiftUI

// MARK: - ListFriendUserView
struct ListFriendUserView: View {

    /// presentor
    @ObservedObject var presentor: ListFriendUserPresentor

    var body: some View {
        NavigationView {
            /// Таблица
            List(presentor.arrayFriend) { object in
                Section(header: Text("\(String(object.key))")) {
                    ForEach(object.data) { friend in
                        // Ссылка на ячейку
                        ListFriendUserRow(friend: friend)
                    }
                }
                .navigationTitle("Друзья Пользователя")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .listStyle(.plain)
        .onAppear {
            presentor.getListFriendUser()
        }

    }
}
