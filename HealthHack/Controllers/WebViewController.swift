//
//  WebViewController.swift
//  HealthHack
//
//  Created by sehooon on 2022/12/26.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Properties
    var url: String = ""
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView(){
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let req = URLRequest(url: URL(string: url)!)
        webView.load(req)
    }
    
}

extension WebViewController: WKUIDelegate{

}

extension WebViewController: WKNavigationDelegate{

}


