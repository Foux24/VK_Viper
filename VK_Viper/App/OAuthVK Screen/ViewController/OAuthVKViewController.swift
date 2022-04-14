//
//  OAuthVKViewController.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import UIKit
import WebKit

// MARK: - OAuthVK ViewController
final class OAuthVKViewController: UIViewController {
    
    /// Обработчик исходящих событий
    var output: OAuthVKViewOutput?
    
    /// UIView - View для OAuthVKViewController
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
        self.setupController()
        self.setupWebView()
        self.requestWebViewVK()
    }
}

// MARK: - Extension WKNavigationDelegate
extension OAuthVKViewController: WKNavigationDelegate {
    
    /// Настройка нативного метода webView
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0 .components(separatedBy: "=")}
            .reduce ([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if let token = params["access_token"], let userId = params["user_id"] {
            let dataSession = DataSession(token: token, userId: Int(userId) ?? 0)
            Session.instance.saveDataSession(dataSession)
            print(dataSession)
            output?.dismissScreen()
        }
        decisionHandler(.cancel)
    }
}

// MARK: - Private
private extension OAuthVKViewController {
    
    /// Настроим WebView
    func setupWebView() {
        self.castomView.webView.navigationDelegate = self
        
    }
    
    /// Настроим контроллер
    func setupController() {
        navigationController?.isNavigationBarHidden = true
        presentationController?.delegate = self
    }
    
    /// Загрузка экрана авторизации VK.com
    func requestWebViewVK() {
        output?.setupWKView(with: castomView)
    }
}

// MARK: - Extension OAuthVKViewController on the UIAdaptivePresentationControllerDelegate
extension OAuthVKViewController: UIAdaptivePresentationControllerDelegate {
    
    /// Закрытие свайпом модального окна
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        output?.getWarningAutorization()
    }
}
