//
//  ViewController.swift
//  T2_P_CollectionView
//
//  Created by 寺先生 on 2018/12/17.
//  Copyright © 2018 wu yuansi. All rights reserved.
//



import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var COL_NUM = 2;//每一行有几个单元格
    var events : NSArray!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        let plistPath = bundle.path(forResource: "events", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.events = NSArray(contentsOfFile: plistPath!)
        testExc()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = self.events.count % COL_NUM
        if (num == 0) {//偶数
            print(self.events.count / COL_NUM)
            return self.events.count / COL_NUM
        } else {        //奇数
            return self.events.count / COL_NUM + 1
        }
    }

    
    //MARK: -- UICollectionViewDataSource
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//
//        let num = self.events.count % COL_NUM
//        if (num == 0) {//偶数
//            print(self.events.count / COL_NUM)
//            return self.events.count / COL_NUM
//        } else {        //奇数
//            return self.events.count / COL_NUM + 1
//        }
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath as IndexPath) as! EventCollectionViewCell
        
        let event = self.events[indexPath.section * COL_NUM + indexPath.row] as! NSDictionary
        cell.TestLabel.text = event["name"] as? String
        cell.TestImageView.image = UIImage(named: event["image"] as! String)
        
        return cell
    }
    
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let event = self.events[indexPath.section * COL_NUM + indexPath.row] as! NSDictionary
        NSLog("select event name : %@", event["name"] as! String)
        
    }
}


//MARK: -- private
 private extension ViewController{
    func testExc() -> Void {
        print("---------------------------")
    }
}
