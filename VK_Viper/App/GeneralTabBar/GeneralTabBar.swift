//
//  GeneralTabBar.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

// MARK: - TabBarController
final class GeneralTabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .white
        setupViewControllers()
    }
    
    /// Конфигурируем контроллеры
    private func setupViewControllers() {
        guard let imageMyFriend = UIImage(systemName: "person.fill") else { return }
        guard let imagemyGroup = UIImage(systemName: "person.3.fill") else { return }
        guard let imageNews = UIImage(systemName: "newspaper.fill") else { return }
        
        let myFriend = createNavController(for: ListMyFriendBuilder.build(), title: "Мои друзья", image: imageMyFriend)
        let myGroup = createNavController(for: ListMyFriendBuilder.build(), title: "Мои группы", image: imagemyGroup)
        let myNews = createNavController(for: ListMyFriendBuilder.build(), title: "Новости", image: imageNews)
        
        viewControllers = [myFriend, myGroup, myNews]
    }
    
    ///  Определим метод для настройки NavigationControler-ов
    ///  - Parameters:
    ///   - rootVC: ViewController
    ///   - title: Имя вкладки
    ///   - image: Картинка вкладки
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        rootViewController.navigationItem.backButtonTitle = ""
        rootViewController.view.safeAreaLayoutGuide.owningView?.backgroundColor = .white
        navController.navigationBar.backgroundColor = .white
        return navController
    }
}
