//
//  Errors.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import Foundation

// MARK: - Error
/// Ошибки при состалвении запроса к АПИ
enum ErrorRequest: Error {
    case parseError
    case taskError
}

// MARK: - Parses Errors VK
struct Errors: Codable {
    let error: ErrorVK
}

struct ErrorVK: Codable, Error {
    let errorCode: Int
    let errorMsg: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}
