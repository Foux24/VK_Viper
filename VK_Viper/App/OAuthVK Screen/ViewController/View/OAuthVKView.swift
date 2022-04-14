//
//  OAuthVKView.swift
//  VK_Viper
//
//  Created by Vitalii Sukhoroslov on 14.04.2022.
//

import WebKit

/// View для OAuthVKViewController
final class OAuthVKView: UIView {
    
    /// Web View
    private(set) lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Инициализтор
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addWebViewInView()
        self.setupConstreints()
    }
    
    /// - Parameter aDecoder: aDecoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: - Private
private extension OAuthVKView {
    
    /// Добавим WKWebView на OAuthVKView
    func addWebViewInView() {
        self.addSubview(webView)
    }
    
    /// Раставим констрейнты
    func setupConstreints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
