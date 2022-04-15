//
//  JSONModelTokenValid.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation

// MARK: - JSONModelTokenValid
struct JSONModelTokenValid: Codable {
    let response: TokenValid
}

struct TokenValid: Codable {
    let success: Int

    enum CodingKeys: String, CodingKey {
        case success
    }
}
