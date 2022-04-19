//
//  ProfileFriendPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI
import Combine

/// Модель для ячейки с фото
struct PhotoFriendData: Identifiable {
    var id: UUID = UUID()
    var friendPhoto: String
}

/// Модель для данных рода деятельности
struct SetupOccupation {
    var imageOccupation = ""
    var textOccupation = ""
}

/// presentor для ProfileFriendView
final class ProfileFriendPresentor: ObservableObject {
    
    /// id пользователя
    var idUser: Int
    
    /// Данные профиля друга
    @Published private(set) var userInfo: [UserInfo] = []
    
    /// Друзья Друга
    @Published private(set) var userFriend: [Friends] = []
    
    /// Массив УРЛ(фото) пользователя
    @Published private(set) var arrayURLPhoto: [PhotoFriendData] = []
    
    /// Массив с последними 6 фото пользователя
    @Published private(set) var arraySuffix6URLPhoto: [PhotoFriendData] = []
    
    /// Состояние для алерта при нажатии на неиспользуемые кнопки
    @Published var showdefaultAlert = false
    
    /// Состояние анимации аватарки
    @Published var isAnimatedZomm = false
    
    /// Индекс выбранной ячейки
    @Published var selectedRow: Int? = nil
    
    /// Высота Ячейки
    @Published var rowHeight: CGFloat? = nil
    
    /// Флаг состояния Нажатия на ячейку
    @Published var stateSelectPhoto: Bool = false
    
    /// Флаг состояния для перехода на список друзей пользователя
    @Published var stateShowListFriendUser: Bool = false
    
    /// Флаг состояния для перехода на список фотографий пользователя
    @Published var stateShowAllPhotoUserUser: Bool = false
    
    /// Количество столбцов в коллекции фотографий
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity)),
        GridItem(.flexible(minimum: 10, maximum: .infinity))
    ]
    
    /// IDFriendUser
    var idFriendUser: Int = 0
    
    /// Формат даты
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.LLL HH:mm"
        df.locale = Locale(identifier: "ru_RU")
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return df
    }()
    
    /// Interactor
    private let interactor: ProfileFriendInteractorInput

    /// Инициализтор
    /// - Parameter dataFriend: Общие данные друга переданные с таблицы
    init(idUser: Int, interactor: ProfileFriendInteractorInput) {
        self.idUser = idUser
        self.interactor = interactor
    }
    
    /// Получения информации о друге
    func getUserInfo() -> Void {
        let idFriend = String(self.idUser)
        self.interactor.getUserInfo(idFriend: idFriend) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userInfo):
                self.userInfo.removeAll()
                self.userInfo = userInfo
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Получение списка друзей друга
    func getListUserFriends() -> Void {
        let idFriend = String(self.idUser)
        self.interactor.getListFriend(idFriend: idFriend) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listFriends):
                self.userFriend.removeAll()
                self.userFriend = listFriends
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Получение списка фотографий пользователя
    func getAllPhotoUser() -> Void {
        let idFriend = String(self.idUser)
        self.interactor.getAllUserPhoto(idFriend: idFriend) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let allPhoto):
                self.arrayURLPhoto.removeAll()
                self.arraySuffix6URLPhoto.removeAll()
                self.arrayURLPhoto = self.sortImage(by: .p, from: allPhoto)
                self.arraySuffix6URLPhoto = self.arrayURLPhoto.suffix(6)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Метод для конвертации даты
    func formateDate() -> String {
        let time = self.userInfo.first?.lastSeen.time ?? 0
        var dateFormate = ""
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateString = self.dateFormatter.string(from: date as Date)
        dateFormate = dateString
        return dateFormate
    }
    
    /// смена состояния флага показа дефолтного алерта
    func changeStateDefaultAlert() {
        self.showdefaultAlert = true
    }
    
    /// смена состояния анимации автарки
    func changeStateAnumateAvatar() {
        self.isAnimatedZomm.toggle()
    }
    
    /// Смена состояния выделенной ячейки в коллекции фотографий
    func changeStateSelectCellUserPhoto() {
        self.stateSelectPhoto.toggle()
    }
    
    /// Смена состояния stateShowListFriendUser после перехода на профиль
    func changeStateShowListFriendUser() {
        self.stateShowListFriendUser = false
    }
    
    /// Метод конфигурации рода деятельности
    /// - Parameter typeOccupartion: Тип рода деятельности
    func setupOccupation(by typeOccupartion: Occupation.TypeOccupation) -> SetupOccupation {
        var occupation = SetupOccupation(imageOccupation: "", textOccupation: "")
        if typeOccupartion == Occupation.TypeOccupation.school {
            occupation.imageOccupation = "book"
            occupation.textOccupation = "Школа:"
        } else if typeOccupartion == Occupation.TypeOccupation.university {
            occupation.imageOccupation = "graduationcap"
            occupation.textOccupation = "Образование:"
        } else {
            occupation.imageOccupation = "briefcase"
            occupation.textOccupation = "Место работы:"
        }
        return occupation
    }
    
    /// Переход на профиль пользователя
    /// - Parameter idUser: ID пользователя
    func showFriendProfileView(idUser: Int) -> some View {
        let urlConfigurator = URLConfigurator()
        let service = ProfileFriendService(urlConfigurator: urlConfigurator)
        let interactor = ProfileFriendInteractor(service: service)
        let profileFriendPresentor = ProfileFriendPresentor(idUser: idUser, interactor: interactor)
        let profileView = ProfileFriendView(presentor: profileFriendPresentor)
        return profileView
    }
    
    /// переход на список друзей пользователя
    func showListFriendUserView(idUser: Int) -> some View {
        let urlConfigurator = URLConfigurator()
        let service = ListFriendUserService(urlConfigurator: urlConfigurator)
        let interactor = ListFriendUserInteractor(service: service)
        let listFriendUserPresentor = ListFriendUserPresentor(idUser: idUser, interactor: interactor)
        let listFriendUserView = ListFriendUserView(presentor: listFriendUserPresentor)
        return listFriendUserView
    }
}

/// Private
private extension ProfileFriendPresentor {
    
    /// Метод сортировки фото по передаваемому типу
    /// - Parameters:
    ///  - sizeType: Размер изображения
    ///  - array: Массив дрзей полученных с сервера
    func sortImage(by sizeType: Size.EnumType, from array: [PhotoUser]) -> [PhotoFriendData] {
        var imageLinks: [PhotoFriendData] = []
        for model in array {
            for size in model.sizes {
                if size.type == sizeType {
                    imageLinks.append(PhotoFriendData(friendPhoto: size.url))
                }
            }
        }
        return imageLinks
    }
}
