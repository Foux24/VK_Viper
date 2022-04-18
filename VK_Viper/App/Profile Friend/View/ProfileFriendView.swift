//
//  ProfileFriendView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI
import Kingfisher
import ASCollectionView

// MARK: - ProfileFriendView
struct ProfileFriendView: View {
    
    /// presentor
    @ObservedObject var presentor: ProfileFriendPresentor
    
    /// Body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    VStack {
                        // MARK: - Header profile section
                        VStack {
                            HStack {
                                VStack {
                                    /// Аватарка
                                    KFImage(URL(string: presentor.userInfo.first?.photo200_Orig ?? ""))
                                        .cancelOnDisappear(true)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .setCastomAvatarEffects()
                                        .padding([.leading, .top])
                                        .scaleEffect(self.presentor.isAnimatedZomm ? 0.7 : 1)
                                        .onTapGesture {
                                            self.presentor.changeStateAnumateAvatar()
                                            withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.2, blendDuration: 0.2)) {
                                                self.presentor.changeStateAnumateAvatar()
                                            }
                                        }
                                }
                                /// Имя, статус, последний раз был в сети
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(presentor.userInfo.first?.firstName ?? "") \(presentor.userInfo.first?.lastName ?? "")")
                                        .lineLimit(1)
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                    if presentor.userInfo.first?.status != "" {
                                        Text(presentor.userInfo.first?.status ?? "")
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
                                Button(action: presentor.changeStateDefaultAlert) {
                                    Text("Сообщение")
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color.white)
                                        .padding([.top, .bottom], 5)
                                }
                                .frame(width: proxy.size.width / 2.2)
                                .background(Color.blue)
                                .cornerRadius(6)
                                .alert(isPresented: $presentor.showdefaultAlert, content: {
                                    Alert(title: Text("Error"), message: Text("Error"))
                                })
                                
                                Button(action: presentor.changeStateDefaultAlert) {
                                    Text("Звонок")
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(Color.white)
                                        .padding([.top, .bottom], 5)
                                }
                                .frame(width: proxy.size.width / 2.2)
                                .background(Color.blue)
                                .cornerRadius(6)
                                .alert(isPresented: $presentor.showdefaultAlert, content: {
                                    Alert(title: Text("Error"), message: Text("Error"))
                                })
                                
                            }
                            /// Кнопки В друзьях/Позвонить, отправить деньги, отправить подарок
                            HStack(alignment: .center, spacing: 90) {
                                Button(action: presentor.changeStateDefaultAlert) {
                                    VStack {
                                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                        Text("В друзьях")
                                            .font(.system(size: 10, weight: .medium, design: .default))
                                    }
                                }
                                .scaleEffect(1.3)
                                .alert(isPresented: $presentor.showdefaultAlert, content: {
                                    Alert(title: Text("Error"), message: Text("Error"))
                                })
                                
                                Button(action: presentor.changeStateDefaultAlert) {
                                    VStack {
                                        Image(systemName: "creditcard")
                                        Text("Деньги")
                                            .font(.system(size: 10, weight: .medium, design: .default))
                                    }
                                }
                                .scaleEffect(1.3)
                                .alert(isPresented: $presentor.showdefaultAlert, content: {
                                    Alert(title: Text("Error"), message: Text("Error"))
                                })
                                
                                Button(action: presentor.changeStateDefaultAlert) {
                                    VStack {
                                        Image(systemName: "gift")
                                        Text("Подарок")
                                            .font(.system(size: 10, weight: .medium, design: .default))
                                    }
                                }
                                .scaleEffect(1.3)
                                .alert(isPresented: $presentor.showdefaultAlert, content: {
                                    Alert(title: Text("Error"), message: Text("Error"))
                                })
                            }
                            .frame(height: 60)
                        }
                        
                        /// Граница между вьюхами
                        HStack {
                        }
                        .frame(width: proxy.size.width / 1.1, height: 2)
                        .background(Color.gray)
                        .cornerRadius(8)
                        
                        // MARK: - Detail UserInfo section
                        VStack(alignment: .leading, spacing: 10) {
                            /// City
                            HStack {
                                Image(systemName: "house")
                                    .foregroundColor(Color.gray)
                                Text("Город: \(presentor.userInfo.first?.city?.title ?? "Неизвестно")")
                                    .font(.system(size: 14, weight: .light, design: .default))
                                    .foregroundColor(Color.gray)
                                Spacer()
                                
                            }
                            /// Род деятельности
                            if presentor.userInfo.first?.occupation != nil || presentor.userInfo.first?.occupation?.name == "" {
                                let typeOccupation = self.presentor.setupOccupation(by: presentor.userInfo.first?.occupation?.type ?? .university)
                                HStack {
                                    Image(systemName: typeOccupation.imageOccupation)
                                        .foregroundColor(Color.gray)
                                    Text(typeOccupation.textOccupation)
                                        .font(.system(size: 14, weight: .light, design: .default))
                                        .foregroundColor(Color.gray)
                                    Text(presentor.userInfo.first?.occupation?.name ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .light, design: .default))
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing, 40.0)
                                    Spacer()
                                }
                            }
                            /// Кол-во подписчиков
                            if presentor.userInfo.first?.followersCount != nil {
                                HStack {
                                    Image(systemName: "dot.radiowaves.up.forward")
                                        .foregroundColor(Color.gray)
                                        .padding(.leading, 5.0)
                                    Text("\(presentor.userInfo.first?.followersCount ?? 0) Подписчик(ов)")
                                        .font(.system(size: 14, weight: .light, design: .default))
                                        .foregroundColor(Color.gray)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.leading)
                        
                        /// Граница между вьюхами
                        HStack {
                        }
                        .frame(width: proxy.size.width / 1.1, height: 2)
                        .background(Color.gray)
                        .cornerRadius(8)
                        
                        // MARK: - Friend User Section
                        /// Header Section
                        if presentor.userFriend.count > 0 {
                        HStack(spacing: 5) {
                            Text("ДРУЗЬЯ")
                                .font(.system(size: 14, weight: .medium, design: .default))
                            Text("\(presentor.userFriend.count)")
                                .font(.system(size: 14, weight: .light, design: .default))
                                .foregroundColor(Color.gray)
                            Circle()
                                .scaleEffect(1)
                                .foregroundColor(Color.gray)
                                .frame(width: 2, height: 2)
                            Text("\(presentor.userInfo.first?.commonCount ?? 0) общих")
                                .font(.system(size: 14, weight: .light, design: .default))
                                .foregroundColor(Color.gray)
                            Spacer()

                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 5.0)
                        }
                        .onTapGesture {
                            self.presentor.stateShowListFriendUser = true
                        }
                        .padding([.leading, .trailing])
                        .sheet(isPresented: $presentor.stateShowListFriendUser, content: {
                            self.presentor.showListFriendUserView(idUser: presentor.idUser)
                        })
                        /// Коллекция (список друзей)
                        ASCollectionView(data: presentor.userFriend) { friend, _ in
                            NavigationLink(destination: self.presentor.showFriendProfileView(idUser: friend.id)) {
                            UserFriendsViewCollectionCell(avatar: friend.photo200_Orig,
                                                          firstName: friend.firstName,
                                                          lastName: friend.lastName)
                            }
                            .scaleEffect(0.9)
                        }
                        .layout(scrollDirection: .horizontal) {
                            .list(
                                itemSize: .absolute(80),
                                sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                            )
                        }
                        .frame(height: 140)
                        
                        /// Граница между вьюхами
                        HStack {
                        }
                        .frame(width: proxy.size.width / 1.1, height: 2)
                        .background(Color.gray)
                        .cornerRadius(8)
                        }
                        
                        // MARK: - Photo User Section
                        // Header photo user Section
                        if presentor.arrayURLPhoto.count > 0 {
                        VStack(spacing: 5) {
                            HStack {
                                Text("ФОТОГРАФИИ")
                                    .font(.system(size: 14, weight: .medium, design: .default))
                                Text("\(presentor.arrayURLPhoto.count)")
                                    .font(.system(size: 14, weight: .light, design: .default))
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(Color.gray)
                                    .padding(.leading, 5.0)
                            }
                            
                            /// Коллекция из 6 последних фотографий
                            LazyVGrid(columns: presentor.columns, alignment: .center, spacing: 8) {
                                ForEach(0..<self.presentor.arraySuffix6URLPhoto.count, id: \.self) { index in
                                    PhotoUserViewCollectionCell(
                                        photoFriend: self.presentor.arraySuffix6URLPhoto[index],
                                        isSelected: self.presentor.selectedRow == index
                                    )
                                    .frame(height: presentor.rowHeight)
                                    .onTapGesture {
                                        withAnimation {
                                            self.presentor.changeStateSelectCellUserPhoto()
                                            self.presentor.selectedRow = index
                                        }
                                    }
                                    .matchedGeometryEffect(id: index, in: self.presentor.namespace)
                                }
                            }
                            .onPreferenceChange(PhotoFriendRowHeightPreferenceKey.self) { height in
                                self.presentor.rowHeight = height
                            }
                            
                        }
                        .padding([.leading, .trailing])
                        
                        /// Граница между Вьюхами
                        HStack {
                        }
                        .frame(width: proxy.size.width, height: 12)
                        .background(Color.gray)
                        }
                    }
                }
            }
        }
        .onAppear {
            presentor.getUserInfo()
            presentor.getListUserFriends()
            presentor.getAllPhotoUser()
            presentor.changeStateShowListFriendUser()
        }
        .navigationTitle(presentor.userInfo.first?.domain ?? "")
    }
    

}
