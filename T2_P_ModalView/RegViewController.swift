//
//  RegViewController.swift
//  T2_P_ModalView
//
//  Created by 寺先生 on 2018/12/20.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func saveUserRegData(_ sender: Any) {
        //点击save后 关闭模态视图
        self.dismiss(animated: true) {
            NSLog("%@", "点击保存，关闭模态视图。")
            let dataDict = NSDictionary(object: self.phoneNumberTextField.text!, forKey: "phoneNumber" as NSCopying)
            
    
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterNotification"), object: nil, userInfo: dataDict as? [AnyHashable : Any])
          
            
        }
    }
    
    @IBAction func cancelOperation(_ sender: Any) {
        self.dismiss(animated: true) {
            NSLog("%@", "点击取消，关闭模态视图。")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
