//
//  NewsWebViewViewController.swift
//  KwikMartProject
//
//  Created by Ram on 07/04/21.
//

import UIKit
import WebKit
class NewsWebViewViewController: UIViewController, WKUIDelegate {
   var webView: WKWebView!
    var newsUrl:String = ""
    var myURL:URL!
    var myRequest:URLRequest!
   override func viewDidLoad() {
      super.viewDidLoad()
    
   }
    override func viewDidAppear(_ animated: Bool) {
        print(newsUrl)
        webView.load(URLRequest(url: (URL(string: newsUrl) ?? URL(string: "https://www.thehindu.com/"))!))
    }
   override func loadView() {
      let webConfiguration = WKWebViewConfiguration()
      webView = WKWebView(frame: .zero, configuration: webConfiguration)
      webView.uiDelegate = self
      view = webView
   }
}
