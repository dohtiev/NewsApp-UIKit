//
//  ArticleDetailViewController.swift
//  NewsApp UIKit
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
//    Getting the url of the selected article via segue
    var urlFromMainView: String = ""
    
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: urlFromMainView)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
