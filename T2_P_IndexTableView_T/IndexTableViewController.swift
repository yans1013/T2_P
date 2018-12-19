//
//  T2_P_IndexTableViewController.swift
//  T2_P_TableView
//
//  Created by 寺先生 on 2018/12/18.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class T2_P_IndexTableViewController: UITableViewController {
    
    fileprivate var dictData: NSDictionary!
    fileprivate var listGroupname: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        let listPath = bundle.path(forResource: "team_dictionary", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: listPath!)
        
        let tempList = self.dictData.allKeys as NSArray
        //对key进行排序
        self.listGroupname = tempList.sortedArray(using: #selector(NSNumber.compare(_:))) as NSArray
    }
    
    // MARK: - tableView中的节数 Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.listGroupname.count
    }
    
    // MARK: -- 每个section中的cell数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 根据节索引从小组中获得q组名
        let groupName = self.listGroupname[section] as! String
        //将组名作为key,取出对应的球队数组
        let listTeams = self.dictData[groupName] as! NSArray
        return listTeams.count
    }
    
    //MARK: -- 填充每个cell中的数据
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        //得到选中的节
        let section = indexPath.section
        //得到选中节中的行
        let row = indexPath.row
        //按照节得到选中的组名
        let groupName = self.listGroupname[section] as! String
        //组名作为key,取出对应的球队数据集合
        let listTeams = self.dictData[groupName] as! NSArray
        cell.textLabel?.text = listTeams[row] as? String
        
        return cell
    }
    
    //MARK:-- 设置section头部的标题
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupName = self.listGroupname[section] as! String
        return groupName
     }
    
    //MARK:-- 设置section尾部的标题
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        let groupName = self.listGroupname[section] as! String
//        return groupName
//    }
    
    //MARK:-- UITableViewDataSource 添加索引目录标题
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        //将A组改为索引A
        for item in self.listGroupname{
            let title = (item as! String).prefix(1)
            listTitles.append(String(title))
        }
        
        return listTitles
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

