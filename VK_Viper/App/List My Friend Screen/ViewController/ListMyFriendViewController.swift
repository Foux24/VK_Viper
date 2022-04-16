//
//  ListMyFriendViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/// Входной протокол List My Friend ViewController
protocol ListMyFriendViewControllerInput: AnyObject {
    /// Показать алерт
    ///  - Parameters:
    ///   - title: Заголовок,
    ///   - message: Сообщение
    func showAlert(title: String, message: String) -> Void
    
    /// Список друзей
    var listMyFriend: [FriendSection] { get set }
}

// MARK: - ListMyFriendViewController
final class ListMyFriendViewController: UIViewController {
    
    /// Список друзей
    var listMyFriend = [FriendSection]() {
        didSet {
            castomView.tableView.reloadData()
        }
    }
    
    /// UIView - view для List My Friend VIewController
    private var castomView: ListMyFriendView {
        return self.view as! ListMyFriendView
    }
    
    /// Обработчик исходящих событий
    var output: ListMyFriendViewControllerOutput?
    
    /// Хэш Изображений
    var fileManager: HashImageService?
    
    /// Life Cycle loadView
    override func loadView() {
        super.loadView()
        self.view = ListMyFriendView()
    }
    
    /// life Cycle View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.output?.getListFriends()
        fileManager = HashImageService(container: castomView.tableView)
    }
}

/// Extension ListMyFriendViewController on the DataSource TableView
extension ListMyFriendViewController: UITableViewDataSource {
    
    /// Количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        listMyFriend.count
    }
    
    /// Кол-во строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listMyFriend[section].data.count
    }
    
    /// Тайтл Хеадера
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = listMyFriend[section]
        return String(section.key)
    }
    
    /// конфигурация ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castomView.tableView.dequeueReusableCell(forIndexPath: indexPath) as ListMyFriendTableViewCell
        let friend = listMyFriend[indexPath.section].data[indexPath.row]
        let image = fileManager?.getImage(atIndexPath: indexPath, byUrl: friend.photo200_Orig)
        cell.configurationCell(image: image, nameFriend: "\(friend.firstName) \(friend.lastName)", status: friend.status)
        return cell
    }
    
    
}
/// Extension ListMyFriendViewController on the Delegate TableView
extension ListMyFriendViewController: UITableViewDelegate {
    
    /// Выделение ячейка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        castomView.tableView.deselectRow(at: indexPath, animated: true)
    }
}

/// Extension ListMyFriendViewController on the ListMyFriendViewControllerInput
extension ListMyFriendViewController: ListMyFriendViewControllerInput {
    /// Показ алерта
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private
private extension ListMyFriendViewController {
    
    /// Настройка таблицы
    func setupTableView() {
        castomView.tableView.registerCell(ListMyFriendTableViewCell.self)
        castomView.tableView.dataSource = self
        castomView.tableView.delegate = self
    }
}
