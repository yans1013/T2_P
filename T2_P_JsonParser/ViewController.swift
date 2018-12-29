//
//  ViewController.swift
//  T2_P_JsonParser
//
//  Created by 寺先生 on 2018/12/27.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listData: [[String:String]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Notes", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)!
        
        do{
            let jsonObj = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            self.listData = jsonObj["Record"] as? [[String:String]]
            print(self.listData.first!)
            
        }catch{
            print("JSON解码失败")
        }
    }


}

