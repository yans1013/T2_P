//
//  TableViewController.swift
//  T2_P_DeleteAddCell
//
//  Created by 寺先生 on 2018/12/19.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    var listTeams: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Cell add or delete"
        
        //cell textField
        self.textField.isHidden = true
        self.textField.delegate = self
        
        //load data
        self.listTeams = NSMutableArray(array: ["红","黄","蓝","白"])
        
    }
    
    //MARK: -- UIViewController 响应视图编辑状态变化
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        
        if editing{
            self.textField.isHidden = false
        }else{
            self.textField.isHidden = true
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listTeams.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        // 当前装载数据的cell是不是最后一行
        let b_addCell = (indexPath.row == self.listTeams.count)
        
        //如果不是最后一行,显示数据cell
        if !b_addCell{
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.listTeams[indexPath.row] as? String
        //如果是最后一行的加入add TextField
        }else{
            self.textField.frame = CGRect(x: 40, y: 0, width: 300, height: cell.frame.size.height)
            self.textField.borderStyle = .none
            self.textField.placeholder = "Add..."
            self.textField.text = ""
            cell.addSubview(self.textField)
        }

        return cell
    }
    
    //MARK: -- 设定指定行cell的编辑图标格式
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //最后一行显示 + 标示，其他行显示 - 标示
        if indexPath.row == self.listTeams.count{
            return .insert
        }else{
            return .delete
        }
    }
    
    //MARK: UITableViewDelegate -- 用于实现单元格的插入或删除
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
     if editingStyle == .delete {
        // Delete the row from the data source
        self.listTeams.removeObject(at: indexPath.row)
        // Delete the row from the tableView
        tableView.deleteRows(at: [indexPath], with: .fade)
        print(indexPath)
        
     } else if editingStyle == .insert {
        // Add the row to the data source
        self.listTeams.insert(self.textField.text!, at: self.listTeams.count)
        // Add the row to the tableView
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
     }
        tableView.reloadData()
     }
    
    //MARK: UITableViewDelegate
    // 直接用户使用最后一个cell
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == self.listTeams.count{
            return false
        }else{
            return true
        }
    }
    
    //设置左滑动删除文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
