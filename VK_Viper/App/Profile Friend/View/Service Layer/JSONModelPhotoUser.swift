//
//  JSONModelPhotoUser.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 17.04.2022.
//

import Foundation

/// JSONModelPhotoUser
struct JSONModelPhotoUser: Codable {
    var response: ResponsePhoto
}

/// ResponsePhoto
struct ResponsePhoto: Codable {
    var count: Int
    var items: [PhotoUser]
}

/// PhotoUser
struct PhotoUser: Codable {
    var albumID, date, id, ownerID: Int
    var lat, long: Double?
    var postID: Int?
    var sizes: [Size]
    var text: String
    var likes: Likes
    var reposts: Reposts

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case lat, long
        case postID = "post_id"
        case sizes, text, likes, reposts
    }
}

/// Likes
struct Likes: Codable {
    var userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

/// Reposts
struct Reposts: Codable {
    var count: Int
}

/// Size
struct Size: Codable {
    var height: Int
    var url: String
    var type: EnumType
    var width: Int
    
    enum EnumType: String, Codable {
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}
