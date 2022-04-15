//
//  ListMyFriendViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

protocol ListMyFriendViewControllerInput: AnyObject {
    
}

// MARK: - ListMyFriendViewController
final class ListMyFriendViewController: UIViewController {
    
    /// Обработчик исходящих событий
    var output: ListMyFriendViewControllerOutput?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.getListFriends()
    }
}

extension ListMyFriendViewController: ListMyFriendViewControllerInput {}
