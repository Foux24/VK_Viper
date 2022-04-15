//
//  JSONModelListMyFriend.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation

/// JSONModelListMyFriend
struct JSONModelListMyFriend: Codable {
    var response: ListMyFriend
}

/// ListMyFriend
struct ListMyFriend: Codable {
    var count: Int
    var items: [MyFriend]
}

/// MyFriend
struct MyFriend: Codable {
    var firstName: String
    var id: Int
    var lastName: String
    var photo200_Orig: String
    var status: String?
    var domain: String?
    var lastSeen: LastSeen?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo200_Orig = "photo_200_orig"
        case status = "status"
        case domain
        case lastSeen = "last_seen"
    }
}

/// LastSeen
struct LastSeen: Codable {
    var time: Double
    
    enum CodingKeys: String, CodingKey {
        case time
    }
}
