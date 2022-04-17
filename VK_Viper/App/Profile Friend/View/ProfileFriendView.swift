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
    
    /// Картинка рода деятельности
    @State private var imageOccupation: String = "house"
    
    /// Текст рода деятельности
    @State private var textOccupation: String = "Образование"
    
    /// Состояние для алерта при нажатии на неиспользуемые кнопки
    @State private var showdefaultAlert = false
    
    /// Состояние анимации аватарки
    @State private var isAnimatedZomm = false
    
    /// Состояние статуса Нажатия на ячейку
    @State private var stateSelectPhoto: Bool = false
    
    /// Высота Ячейки
    @State private var rowHeight: CGFloat? = nil
    
    /// Высота Ячейки
    @State private var rowHeightFriend: CGFloat? = nil
    
    /// Индекс выбранной ячейки
    @State private var selectedRow: Int? = nil
    
    /// NameSpace
    @Namespace var namespace
    
    /// Количество столбцов
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity))
    ]
    
    /// Body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
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
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "house")
                                    .foregroundColor(Color.gray)
                                Text("Город: \(presentor.userInfo?.city?.title ?? "")")
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
                        .padding(.leading)
                        
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
                            Text("\(presentor.userInfo?.commonCount ?? 0) общих")
                                .font(.system(size: 14, weight: .light, design: .default))
                                .foregroundColor(Color.gray)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 5.0)
                        }
                        .padding([.leading, .trailing])
                        
                        ASCollectionView(data: presentor.userFriend) { friend, _ in
                            UserFriendsViewCollectionCell(avatar: friend.photo200_Orig,
                                                          firstName: friend.firstName,
                                                          lastName: friend.lastName)
                            .scaleEffect(0.9)
                        }
                        .layout(scrollDirection: .horizontal) {
                            .list(
                                itemSize: .absolute(80),
                                sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                            )
                        }
                        .frame(height: 140)
                        /// Граница вьюхи
                        HStack {
                        }
                        .frame(width: proxy.size.width / 1.1, height: 2)
                        .background(Color.gray)
                        .cornerRadius(8)
                        
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
                            LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                                ForEach(0..<self.presentor.arraySuffix6URLPhoto.count, id: \.self) { index in
                                    PhotoUserViewCollectionCell(
                                        photoFriend: self.presentor.arraySuffix6URLPhoto[index],
                                        isSelected: self.selectedRow == index
                                    )
                                    .frame(height: rowHeight)
                                    .onTapGesture {
                                        withAnimation {
                                            self.stateSelectPhoto.toggle()
                                            self.selectedRow = index
                                        }
                                    }
                                    .matchedGeometryEffect(id: index, in: self.namespace)
                                }
                            }
                            .onPreferenceChange(PhotoFriendRowHeightPreferenceKey.self) { height in
                                self.rowHeight = height
                            }

                        }
                        .padding([.leading, .trailing])
                        
                        /// Граница вьюхи
                        HStack {
                        }
                        .frame(width: proxy.size.width, height: 12)
                        .background(Color.gray)
                    }
                }
            }
        }
        .onAppear {
            presentor.getUserInfo()
            presentor.getListUserFriends()
            presentor.getAllPhotoUser()
        }
        .navigationTitle(presentor.userInfo?.domain ?? "")
    }
    
    /// Дефолтное действие кнопкам
    func defaultActionButton() {
        self.showdefaultAlert = true
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
