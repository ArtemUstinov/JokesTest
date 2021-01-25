//
//  ApiViewController.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit
import WebKit

class ApiViewController: UIViewController {
    
    //MARK: - UI Elements:
    private let webView = WKWebView()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
            
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy private var backButton = UIBarButtonItem(title: "Back",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(backTapped))
    lazy private var forwardButton = UIBarButtonItem(title: "Forward",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(forwardTapped))
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupNavigationBar()
        setupWebView()
        setupLayouts()
    }
    
    //MARK: - Setup NavBar
    private func setupNavigationBar() {
        webView.navigationDelegate = self
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = forwardButton
        navigationItem.title = ApiURL.website
        
    }
    
    //MARK: - Setup WebView
    private func setupWebView() {
        let homePage = ApiURL.website
        guard let url = URL(string: homePage) else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
        self.webView.allowsBackForwardNavigationGestures = true
        DispatchQueue.main.async {
            if self.webView.isLoading == false {
                
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    //MARK: - Button targets:
    @objc func backTapped() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func forwardTapped() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    //MARK: - Setup layouts:
    func setupLayouts() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: [webView])
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: [webView])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                       constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                       constant: 0)
        ])
    }
}

//MARK: - WKNavigationDelegate
extension ApiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
