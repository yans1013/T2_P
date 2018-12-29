//
//  ViewController.swift
//  T2_P_AppSettings
//
//  Created by 寺先生 on 2018/12/26.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        let username = defaults.string(forKey: "name_preference")
        NSLog("username: %@", username!)
        
        let password = defaults.string(forKey: "password_preference")
        NSLog("password: %@", password!)
        
        if defaults.bool(forKey: "enabled_preference"){
            
            NSLog("clearCache: %@", "YES")
        }else{
            NSLog("clearCache: %@", "NO")
        }
        
        let sliderStr = String(format: "%.2fGB", defaults.double(forKey: "slider_preference"))
        NSLog("每月流量: %@", sliderStr)
        
        let serverName = defaults.string(forKey: "multivalue_preference")
        NSLog("serverName: %@", serverName!)
//
        if defaults.bool(forKey: "sound_enabled_preference"){
            NSLog("声音打开: %@", "YES")
        }else{
            
            NSLog("声音打开: %@", "NO")
        }
        
        if defaults.bool(forKey: "vibrate_enabled_preference"){
            NSLog("震动打开: %@", "YES")
        }else{
            
            NSLog("震动打开: %@", "NO")
        }
    }


}

