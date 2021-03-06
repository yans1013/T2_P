//
//  DetailViewController.swift
//  T2_P_NavigationComb
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    //代码添加webView
    var url: String!
    var name: String!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addInfo))
        self.navigationItem.rightBarButtonItem = addButtonItem
        
        /// 添加WKWebView
        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)
        self.webView.navigationDelegate = self
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addInfo(sender: AnyObject) {
        let modalViewController = ModalViewController()
        let navigationController = UINavigationController(rootViewController: modalViewController)
        
        //代码管理模态视图
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    // MARK: --实现WKNavigationDelegate委托协议
    //开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("开始加载")
    }
    
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        NSLog("内容开始返回")
    }
    
    //加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("加载完成")
    }
    
    //加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("加载失败 error :  %@", error.localizedDescription)
    }

}
