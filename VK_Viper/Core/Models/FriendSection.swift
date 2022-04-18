//
//  FriendSection.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 16.04.2022.
//

import UIKit

/// Структура для сортировки друзей по ключу
struct FriendSection: Comparable, Identifiable {
    
    /// Ключ
    var key: Character
    
    /// Значение
    var data: [Friends]
    
    /// id
    let id = UUID()
    
    /// Сартировка ключей словаря  <
    static func < (lhs: FriendSection, rhs: FriendSection) -> Bool {
        return lhs.key < rhs.key
    }
    
    /// Сартировка ключей словаря  ==
    static func == (lhs: FriendSection, rhs: FriendSection) -> Bool {
        return lhs.key == rhs.key
    }
}
