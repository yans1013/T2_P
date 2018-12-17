//
//  ViewController.swift
//  T2_P
//
//  Created by 寺先生 on 2018/12/14.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var InputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        InputTextField.placeholder = "Hallo Guys!"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "keyboardDidShowNotification"), object: "haha")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.init(rawValue: "keyboardDidShowNotification"), object: nil)
    }
    
    @objc private func keyboardDidShow(notification: Notification){
        guard  let info = notification.object as? String else {
            return
        }
        debugPrint(info)
    }


}

