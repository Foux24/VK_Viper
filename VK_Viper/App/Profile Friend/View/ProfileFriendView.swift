//
//  ProfileFriendView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI
import Kingfisher

// MARK: - ProfileFriendView
struct ProfileFriendView: View {
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    /// Body
    var body: some View {
        VStack {
            HeaderProfileFriend(presentor: presentor)
        }
        .onAppear {
            presentor.getUserInfo()
            presentor.getListUserFriends()
        }
        .navigationTitle(presentor.userInfo?.domain ?? "")
    }
}

// MARK: - HeaderProfileFriend
struct HeaderProfileFriend: View {
    
    /// Состояние для алерта при нажатии на неиспользуемые кнопки
    @State private var showdefaultAlert = false
    
    /// Состояние анимации аватарки
    @State private var isAnimatedZomm = false
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    /// Body
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                VStack {
                    HStack {
                        VStack {
                            /// Аватарка
                            KFImage(URL(string: presentor.userInfo?.photo200_Orig ?? ""))
                                .cancelOnDisappear(true)
                                .resizable()
                                .setCastomAvatarEffects()
                                .padding([.leading, .top])
                                .scaleEffect(self.isAnimatedZomm ? 0.7 : 1)
                                .onTapGesture {
                                    self.isAnimatedZomm.toggle()
                                    withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.2, blendDuration: 0.2)) {
                                        self.isAnimatedZomm.toggle()
                                    }
                                }
                        }
                        /// Имя, статус, последний раз был в сети
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(presentor.userInfo?.firstName ?? "") \(presentor.userInfo?.lastName ?? "")")
                                .lineLimit(1)
                                .font(.system(size: 18, weight: .medium, design: .default))
                            if presentor.userInfo?.status != "" {
                                Text(presentor.userInfo?.status ?? "")
                                    .lineLimit(1)
                                    .font(.system(size: 14, weight: .regular, design: .default))
                            }
                            Text("Был(а) в сети \(presentor.formateDate())")
                                .lineLimit(1)
                                .font(.system(size: 12, weight: .light, design: .default))
                        }
                        .padding([.leading, .top])
                        Spacer()
                    }
                    /// Кнопки Сообщещение и Звонок/Добавить в друзья
                    HStack(alignment: .center, spacing: 8) {
                        Button(action: defaultActionButton) {
                            Text("Сообщение")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width: proxy.size.width / 2.2)
                        .background(Color.blue)
                        .cornerRadius(6)
                        .alert(isPresented: $showdefaultAlert, content: {
                            Alert(title: Text("Error"), message: Text("Error"))
                        })
                        
                        Button(action: defaultActionButton) {
                            Text("Звонок")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color.white)
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width: proxy.size.width / 2.2)
                        .background(Color.blue)
                        .cornerRadius(6)
                        .alert(isPresented: $showdefaultAlert, content: {
                            Alert(title: Text("Error"), message: Text("Error"))
                        })
                        
                    }
                    /// Кнопки В друзьях/Позвонить, отправить деньги, отправить подарок
                    HStack(alignment: .center, spacing: 70) {
                        Button(action: defaultActionButton) {
                            VStack {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                Text("В друзьях")
                                    .font(.system(size: 10, weight: .medium, design: .default))
                            }
                        }
                        .scaleEffect(1.3)
                        .alert(isPresented: $showdefaultAlert, content: {
                            Alert(title: Text("Error"), message: Text("Error"))
                        })

                        Button(action: defaultActionButton) {
                            VStack {
                                Image(systemName: "creditcard")
                                Text("Деньги")
                                    .font(.system(size: 10, weight: .medium, design: .default))
                            }
                        }
                        .scaleEffect(1.3)
                        .alert(isPresented: $showdefaultAlert, content: {
                            Alert(title: Text("Error"), message: Text("Error"))
                        })
            
                        Button(action: defaultActionButton) {
                            VStack {
                                Image(systemName: "gift")
                                Text("Подарок")
                                    .font(.system(size: 10, weight: .medium, design: .default))
                            }
                        }
                        .scaleEffect(1.3)
                        .alert(isPresented: $showdefaultAlert, content: {
                            Alert(title: Text("Error"), message: Text("Error"))
                        })
                    }
                    .frame(height: 60)
                    
                    /// Граница вьюхи
                    HStack {
                    }
                    .frame(width: proxy.size.width / 1.1, height: 2)
                    .background(Color.gray)
                    .cornerRadius(8)
                }
            }
        }
    }
    /// Дефолтное действие кнопкам
    func defaultActionButton() {
        self.showdefaultAlert = true
    }
}
