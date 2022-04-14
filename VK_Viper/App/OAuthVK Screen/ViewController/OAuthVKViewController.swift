//
//  OAuthVKViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit

// MARK: - OAuthVK ViewController
final class OAuthVKViewController: UIViewController {
    
    private var castomView: OAuthVKView {
        return self.view as! OAuthVKView
    }
    
    /// Life Cycle Load View
    override func loadView() {
        super.loadView()
        self.view = OAuthVKView()
    }
    
    /// Life Cycle - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}
