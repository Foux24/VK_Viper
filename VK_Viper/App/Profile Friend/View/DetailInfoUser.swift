//
//  DetailInfoUser.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import SwiftUI

/// Для настройки Occupation
struct SetupOccupation {
    
    /// Картинка рода деятельности
    var imageOccupation: String
    
    /// Текст рода деятельности
    var textOccupation: String
}

struct DetailInfoUser: View {
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    /// Картинка рода деятельности
    @State private var imageOccupation: String = "house"
    
    /// Текст рода деятельности
    @State private var textOccupation: String = "Образование"
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "house")
                        .foregroundColor(Color.gray)
                    Text("Город: Санкт-Петербург")
                        .font(.system(size: 14, weight: .light, design: .default))
                        .foregroundColor(Color.gray)
                    
                }
                
                if presentor.userInfo?.occupation != nil || presentor.userInfo?.occupation?.name == "" {
                    let typeOccupation = self.setupOccupation(by: presentor.userInfo?.occupation?.type ?? .university)
                    HStack {
                        Image(systemName: typeOccupation.imageOccupation)
                            .foregroundColor(Color.gray)
                        Text(typeOccupation.textOccupation)
                            .font(.system(size: 14, weight: .light, design: .default))
                            .foregroundColor(Color.gray)
                        Text(presentor.userInfo?.occupation?.name ?? "")
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .light, design: .default))
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 40.0)
                    }
                }
                
                if presentor.userInfo?.followersCount != nil {
                    HStack {
                        Image(systemName: "dot.radiowaves.up.forward")
                            .foregroundColor(Color.gray)
                            .padding(.leading, 5.0)
                        Text("\(presentor.userInfo?.followersCount ?? 0) Подписчик(ов)")
                            .font(.system(size: 14, weight: .light, design: .default))
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                }
                /// Граница вьюхи
                HStack {
                }
                .frame(width: proxy.size.width / 1.1, height: 2)
                .background(Color.gray)
                .cornerRadius(8)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(.leading)
        }
    }
    
    /// Метод конфигурации рода деятельности
    func setupOccupation(by typeOccupartion: Occupation.TypeOccupation) -> SetupOccupation {
        var occupation = SetupOccupation(imageOccupation: "", textOccupation: "")
        if typeOccupartion == Occupation.TypeOccupation.school {
            occupation.imageOccupation = "book"
            occupation.textOccupation = "Образование"
        } else if typeOccupartion == Occupation.TypeOccupation.university {
            occupation.imageOccupation = "graduationcap"
            occupation.textOccupation = "Образование"
        } else {
            occupation.imageOccupation = "briefcase"
            occupation.textOccupation = "Место работы"
        }
        return occupation
    }
}
