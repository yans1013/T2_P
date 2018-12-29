//
//  CombTableViewController.swift
//  T2_P_NavigationComb
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class CombTableViewController: UITableViewController {

    var dictData: NSDictionary!
    var listData: NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        dictData = NSDictionary(contentsOfFile: dataPath!)
    
        let navigationController = self.parent as! UINavigationController
        
        //得到选中的tabBarItem的
        let selectedProvince = navigationController.tabBarItem.title!
        
        switch selectedProvince {
        case "H":
            let province = "黑龙江省"
            self.listData = self.dictData[province] as? NSArray
            self.navigationItem.title = province
        case "J":
            let province = "吉林省"
            self.listData = self.dictData[province] as? NSArray
            self.navigationItem.title = province
        default:
            break
        }
        
        
    }
    
    //// UITableViewDelegate 方法，处理列表项的选中事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let itemIndex = indexPath.row
        
        self.performSegue(withIdentifier: "ShowSelectedDetail", sender: itemIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSelectedDetail"{
            let itemIndex = sender as! Int
            let dict = self.listData[itemIndex] as! NSDictionary
            
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.url = dict["url"] as? String
            detailViewController.title = dict["name"] as? String
        }
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
        let dict = self.listData[row] as! NSDictionary
        cell.textLabel?.text = dict["name"] as? String
        
        return cell
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
