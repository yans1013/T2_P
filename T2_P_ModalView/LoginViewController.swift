//
//  LoginViewController.swift
//  T2_P_RefreshControll
//
//  Created by 寺先生 on 2018/12/20.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加入消息监听
        NotificationCenter.default.addObserver(self, selector: Selector(("registerCompleted:")), name: NSNotification.Name(rawValue: "RegisterNotification"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        let userName = self.userNameTextField.text
        let password = self.passwordTextField.text
        
        NSLog("%@,%@", userName!,password!)
    }
    
    //注册按钮已经target 注册模态视图
    
    fileprivate func registerCompleted(notification: Notification){
        let dictData:NSDictionary = notification.userInfo! as NSDictionary
        let phoneNumber = dictData.object(forKey: "phoneNumber") as! NSString
        NSLog("The phoneNumber of registerUser is: %@", phoneNumber)
    }
    
    override func didReceiveMemoryWarning() {
        NotificationCenter.default.removeObserver(self)
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
