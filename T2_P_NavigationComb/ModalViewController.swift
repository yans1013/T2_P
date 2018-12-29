//
//  ModalViewController.swift
//  T2_P_NavigationComb
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveButtonItem
        
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        
        let screen = UIScreen.main.bounds
        
        let textViewWidth:CGFloat = 320
        let textViewHeight: CGFloat = 200
        let textViewTopView: CGFloat = 100
        let cg = CGRect(x: (screen.size.width - textViewWidth)/2, y: textViewTopView, width: textViewWidth, height: textViewHeight)
        let textView = UITextView(frame:cg)
        
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        self.view.addSubview(textView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func save(sender: AnyObject) {
        self.dismiss(animated: true, completion: { () -> Void in
            NSLog("保存返回")
        })
    }
    
    @objc func cancel(sender: AnyObject) {
        self.dismiss(animated: true, completion: { () -> Void in
            NSLog("关闭模态视图")
        })
    }

  
}
