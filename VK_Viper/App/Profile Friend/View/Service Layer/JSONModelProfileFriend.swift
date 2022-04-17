//
//  JSONModelProfileFriend.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import Foundation

// MARK: - ProfileFriend
struct JSONModelProfileFriend: Codable {
    let response: [UserInfo]
}

// MARK: - Response
struct UserInfo: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let domain: String
    let bdate: String?
    let city: City?
    let photo200_Orig: String
    let isFriend: Int
    let status: String
    let lastSeen: LastSeen
    let followersCount: Int?
    let commonCount: Int
    let occupation: Occupation?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case domain, bdate, city
        case photo200_Orig = "photo_200_orig"
        case isFriend = "is_friend"
        case status
        case lastSeen = "last_seen"
        case followersCount = "followers_count"
        case commonCount = "common_count"
        case occupation
    }
}

/// City
struct City: Codable {
    let title: String
}

/// LastSeen
struct LastSeen: Codable {
    var time: Double
    
    enum CodingKeys: String, CodingKey {
        case time
    }
}

/// Occupation
struct Occupation: Codable {
    let name: String
    let type: TypeOccupation
    
    /// Тип занятости
    enum TypeOccupation: String, Codable {
        case school = "school"
        case university = "university"
        case work = "work"
    }
}
