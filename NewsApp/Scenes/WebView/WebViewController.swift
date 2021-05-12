//
//  WebViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 13.05.2021.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
//MARK: - Properties
    var webView: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webRequest(url)
        configureButtons()
    }
    
//MARK: - Life cycle
    private func webRequest(_ url: String?) {
        let myURL = URL(string: url ?? "https://www.apple.com")
          let myRequest = URLRequest(url: myURL!)
          webView.load(myRequest)
    }
    
    private func configureButtons() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonClicked))
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        configureButtons()
    }
    
//MARK: - Button Actions
    @objc func doneButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshButtonClicked() {
        webRequest(url)
    }
}


