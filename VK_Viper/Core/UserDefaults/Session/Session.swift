//
//  Session.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit
import WebKit

// MARK: - Session
final class Session {
    
    /// Singlton к классу Session
    static let instance = Session()
    
    /// Данные сесии
    private(set) var dataSession: DataSession {
        didSet {
            sessionCaretaker.save(dataSession: dataSession)
        }
    }

    /// Инициализтор
    private init(){
        self.dataSession = self.sessionCaretaker.retrieveSession()
    }
    
    /// Caretaker сессии
    private let sessionCaretaker = SessionCaretaker()
    
    /// Сохранение данных сессии
    func saveDataSession(_ dataSession: DataSession) {
        self.dataSession = dataSession
    }

    /// Очистка данных сессии + чистка данных записей автозаполнения в WebView авторизации VK
    func cleanSession() {
        self.dataSession.token = nil
        self.dataSession.userId = nil
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
