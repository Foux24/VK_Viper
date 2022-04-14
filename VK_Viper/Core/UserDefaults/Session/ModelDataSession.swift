//
//  ModelDataSession.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import Foundation

/// Модель DataSession
struct DataSession: Codable {
    
    /// Token
    var token: String?
    
    /// UserId
    var userId: Int?
}
