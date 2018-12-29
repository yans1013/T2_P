//
//  ViewController.swift
//  T2_P_Contact
//
//  Created by 寺先生 on 2018/12/27.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController,UISearchBarDelegate,UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var listContacts: [CNContact]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //实力化UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        
        //设置self为更新搜索结果对象
        self.searchController.searchResultsUpdater = self
        
        //在搜索时背景设置为灰色
        self.searchController.dimsBackgroundDuringPresentation = false
        
        //将搜索栏放到表视图的表头中
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        DispatchQueue.async()
        
    }


}

