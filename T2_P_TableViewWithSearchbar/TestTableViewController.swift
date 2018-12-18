//
//  TestTableViewController.swift
//  T2_P_TableView
//
//  Created by 寺先生 on 2018/12/18.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class TestTableViewController:  UITableViewController, UISearchResultsUpdating, UISearchBarDelegate
{

    //all data
    var listTeams: NSArray!
    // filtered data
    var listFilterTeams: NSArray!
    var searchController: UISearchController!
    let COL_NUM = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        let listPath = bundle.path(forResource: "team", ofType: "plist")
        //fetch all data
        self.listTeams = NSArray(contentsOfFile: listPath!)
        
        //初次进入查询所有数据
        self.filterContentForSearchText(searchText: "", scope: -1)
        
        //实例化UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        
        //设置self为更新搜索结果对象
        self.searchController.searchResultsUpdater = self

        //在搜索时背景颜色为灰色
        self.searchController.dimsBackgroundDuringPresentation = false
        
        //设置搜索范围栏目中的按钮
        self.searchController.searchBar.scopeButtonTitles = ["中文","英文"]
        self.searchController.searchBar.delegate = self
        
        //将搜索栏放到表视图b的表头中
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.sizeToFit()
       
    }

    // MARK: - Table view data source
    /** 设置表视图中section的数量，一个表可以有多个节，节也可以有header和footer,分节是添加索引和分组的前提。如果设置section数大于1，那么很多方法都会变化。我可以使用 tableView:titleForHeaderInSection和table: titleForFooterInsection来设置节头和节脚的标题 **/
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.COL_NUM
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listFilterTeams.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! TestTableViewCell
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

         let row = indexPath.row
//         let rowDict = self.listTeams[row] as! NSDictionary
        
        let rowDict = self.listFilterTeams[row] as! NSDictionary
    
        //cell config
        cell.textLabel?.text = rowDict["name"] as? String
        cell.detailTextLabel?.text = rowDict["image"] as? String
        
        let imagePath = String(format: "%@.png", rowDict["image"] as! String)
//        NSLog("%@", imagePath)
        cell.imageView?.image = UIImage(named: imagePath)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = self.listFilterTeams[indexPath.section * COL_NUM + indexPath.row] as! NSDictionary
        NSLog("select team name : %@", team["name"] as! String)
    }
    

    
    //自定义过滤结果集的方法
    func filterContentForSearchText(searchText:NSString, scope: Int){
        if searchText.length == 0{
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
            return
        }
        var tempArray: NSArray!
        
        if scope == 0{
            //用法参考https://www.jianshu.com/p/bfdacbdf37a7, c表示任意字符,d表示数字
            let scopePredicate = NSPredicate(format: "SELF.name contains[c] %@", searchText)
            //数组过滤
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else if scope == 1{
            let scopePredicate = NSPredicate(format: "SELF.image contains[c] %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else{
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }
//        print(tempArray)
    }
    
    // MARK: -- UISearchBarDelegate协议方法
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
    
    // MARK: -- UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text! as NSString
        self.filterContentForSearchText(searchText: searchString , scope: searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    
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



