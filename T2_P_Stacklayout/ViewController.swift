//
//  ViewController.swift
//  T2_P_Stacklayout
//
//  Created by 寺先生 on 2018/12/20.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let iOSDeviceScreenSize : CGSize = UIScreen.main.bounds.size
        
        NSLog("%@ * %@", iOSDeviceScreenSize.width,iOSDeviceScreenSize.height)
        
//        var st = NSString(format: "%@ * %@", iOSDeviceScreenSize.width,iOSDeviceScreenSize.height)
        
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone{
//            if iOSDeviceScreenSize.height > iOSDeviceScreenSize.width{
//                //竖屏
//                //
//            }
//        }
    }


}

