//
//  HashImageService.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 15.04.2022.
//

import UIKit

/*
 Хэширование изображений
 при работе с таблицами и коллекциями
 */

/// Протокол для ребута ячейки
fileprivate protocol DataReloadable {
    
    /// Ребут ячейки
    /// - Parameter indexPath: Индекс ячейки
    func reloadRow(atIndexPath indexPath: IndexPath)
}

// MARK: - HashImageService
final class HashImageService {
    
    /// Тайм интервал в течении которого кеш актуален
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    /// Словарь [url:Image]
    private var images = [String: UIImage]()
    
    /// Контейнер для таблицы или коллекции
    private let container: DataReloadable
    
    /// инициализтор
    /// - Parameter container: Передаем UITableView
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    /// инициализтор
    /// - Parameter container: Передаем UICollectionView
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    /// создаем папку images
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return pathName}
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    /// Получить изображение
    /// - Parameters:
    ///  - indexpath: Индекс ячейки
    ///  - byUrl: URL изображения
    func getImage(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let dataImage = images[url] {
            image = dataImage
        }else if let dataImage = getImageFromCache(url: url) {
            image = dataImage
        }else{
            loadImage(atIndexPath: indexPath, byUrl: url)
        }
        return image
    }
}

// MARK: - Private
private extension HashImageService {
    
    /// Table
    class Table: DataReloadable {
        
        /// Таблица
        let table: UITableView
        
        /// инициализтор
        /// - Parameter table: Таблица
        init(table: UITableView) {
            self.table = table
        }
        
        /// Ребут строки
        /// - Parameter indexPath: Индекс строки
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    /// Collection
    class Collection: DataReloadable {
        
        /// Коллекция
        let collection: UICollectionView
        
        /// Инициализтор
        /// - Parameter collection: Коллекция
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        /// Ребут ячейки
        /// - Parameter indexPath: Индекс ячейки
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
    
    /// Загрузка изображения из памяти
    /// - Parameter url: url изображения
    func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    /// Конфигурация пути изображения в памяти
    /// - Parameter url: url изображения
    func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(HashImageService.pathName + "/" + hashName).path
    }
    
    /// Загрузка изображения
    /// - Parameters:
    ///  - indexPath: индекс ячейки
    ///  - byUrl: url изображения
    func loadImage(atIndexPath indexPath: IndexPath, byUrl url: String) {
        guard let urlImage = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlImage) { [weak self] (data, response, error) in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexPath: indexPath)
            }
        }.resume()
        
    }
    
    /// Сохранить изображение в памяти
    /// - Parameters:
    ///  - url: url изображения
    ///  - image: Изображение
    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else {return}
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}
