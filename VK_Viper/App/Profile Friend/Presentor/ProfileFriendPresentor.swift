//
//  ProfileFriendPresentor.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import SwiftUI
import Combine

/// ViewModel для ProfileFriendView
class ProfileFriendPresentor: ObservableObject {
    
    /// Общие данный друга
    @Published var dataFriend: Friends
    
    /// Данные профиля друга
    @Published var userInfo: UserInfo?
    
    /// Друзья Друга
    @Published var userFriend: [Friends] = []
    
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
    init(dataFriend: Friends, interactor: ProfileFriendInteractorInput) {
        self.dataFriend = dataFriend
        self.interactor = interactor
    }
    
    /// Получения информации о друге
    func getUserInfo() -> Void {
        let idFriend = String(self.dataFriend.id)
        self.interactor.getUserInfo(idFriend: idFriend) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userInfo):
                self.userInfo = userInfo.first
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Получение списка друзей друга
    func getListUserFriends() -> Void {
        let idFriend = String(self.dataFriend.id)
        self.interactor.getListFriend(idFriend: idFriend) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listFriends):
                self.userFriend = listFriends
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Метод для конвертации даты
    func formateDate() -> String {
        let time = self.userInfo?.lastSeen.time ?? 0
        var dateFormate = ""
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateString = self.dateFormatter.string(from: date as Date)
        dateFormate = dateString
        return dateFormate
    }
}
