//
//  TableViewController.swift
//  T2_P_RefreshControll
//
//  Created by 寺先生 on 2018/12/20.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var logs: NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        //init variable and date
        self.logs = NSMutableArray()
        let date = NSDate()
        self.logs.add(date)
       
        //init refreshController
        let refreshController = UIRefreshControl()
        
        // NSAttributedString 富文本
        refreshController.attributedTitle = NSAttributedString(string: "下拉刷新")
        
        refreshController.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        self.refreshControl = refreshController
    }
    
    
    @objc func refreshTableView(){
        //下拉加载数据
//        guard self.refreshControl?.isRefreshing == false else {
//
//        }
        if self.refreshControl?.isRefreshing == true{
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中...")
            let date = NSDate()
            self.logs.add(date)
            //加载结束
            self.refreshControl?.endRefreshing()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.logs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        // Configure the cell...
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        
        let theDate = self.logs[indexPath.row] as! Date
        cell.textLabel?.text = dateFormatter.string(from: theDate)
        
        cell.accessoryType = .disclosureIndicator
        
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
