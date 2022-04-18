//
//  ListFriendUserRow.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 18.04.2022.
//

import SwiftUI

import SwiftUI
import Kingfisher

struct ListFriendUserRow: View {
    
    /// Пропертя с данными друга
    @State private(set) var friend: Friends

    /// Инициалзитор
    init(friend: Friends) {
        self.friend = friend
    }
    
    /// View
    var body: some View {
        HStack() {
            KFImage(URL(string: friend.photo200_Orig))
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .shadow(color: Color.black, radius: 5)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(friend.firstName) \(friend.lastName)")
                        .font(.system(size: 14))
                }
                Text(friend.status ?? "")
                    .lineLimit(1)
                    .font(.system(size: 12, weight: .light, design: .default))
            }
            Spacer()
            .padding(.leading, 10.0)
        }
        
    }
}
