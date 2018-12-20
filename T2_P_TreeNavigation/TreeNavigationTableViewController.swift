//
//  TreeNavigationTableViewController.swift
//  T2_P_TreeNavigation
//
//  Created by 寺先生 on 2018/12/20.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class TreeNavigationTableViewController: UITableViewController {
    
    var dictData: NSDictionary!
    var listData: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let dataPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: dataPath!)
        self.listData = dictData.allKeys as NSArray
        self.title = "Province Info"
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        // Configure the cell...
        let row = indexPath.row
        cell.textLabel?.text = self.listData[row] as? String

        return cell
    }
    
    //// UITableViewDelegate 方法，处理列表项的选中事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let itemString = self.listData[indexPath.row]
        
        self.performSegue(withIdentifier: "ShowSelectedProvince", sender: itemString)
    }
 
    //MARK:-- 场景过度前的预处理,进行场景挑换时使用吗，segue.destination获得跳转视图的控制器对象
    //从而在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSelectedProvince"{
//            let indexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
//            let selectedIndex = indexPath.row
            let citiesViewController = segue.destination as! CitiesViewController
            
//            let selectName = self.listData[selectedIndex] as! String
            let selectName = sender as! String
            citiesViewController.listData = self.dictData[selectName] as? NSArray
            citiesViewController.title = selectName
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
