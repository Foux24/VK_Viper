//
//  JSONModelListMyFriend.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation

/// JSONModelListMyFriend
struct JSONModelListMyFriend: Codable {
    var response: ListFriend
}

/// ListMyFriend
struct ListFriend: Codable {
    var count: Int
    var items: [Friends]
}

/// MyFriend
struct Friends: Codable, Identifiable {
    var firstName: String
    var id: Int
    var lastName: String
    var photo200_Orig: String
    var status: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo200_Orig = "photo_200_orig"
        case status = "status"
    }
}


