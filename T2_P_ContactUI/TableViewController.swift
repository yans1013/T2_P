//
//  TableViewController.swift
//  T2_P_ContactUI
//
//  Created by 寺先生 on 2018/12/27.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit
import ContactsUI

class TableViewController: UITableViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {

    var listContact: [CNContact]!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化listContact
        self.listContact = [CNContact]()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listContact != nil{
            return listContact.count
        }
        return 0
    }
 
    @IBAction func selectContact(_ sender: Any) {
        let contactPicker = CNContactPickerViewController()
        //定义委托时候才可以与对应的controller交互
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        //数据传递
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        // Configure the cell...
        let contact = self.listContact[indexPath.row]
        let firstName = contact.givenName
        let lastName = contact.familyName
        
        let name = "\(firstName)\(lastName)"
        
        cell.textLabel!.text = name

        return cell
    }
    
    //MARK: -- CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if !listContact.contains(contact){
            self.listContact.append(contact)
            self.tableView.reloadData()
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for contact in contacts where !self.listContact.contains(contact){
            self.listContact.append(contact)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactStore = CNContactStore()
        let selectedContact = self.listContact[indexPath.row]
        
        let keysToFetch = [CNContactViewController.descriptorForRequiredKeys()]
        
        do{
            let contact = try contactStore.unifiedContact(withIdentifier: selectedContact.identifier, keysToFetch: keysToFetch)
            
            let controller = CNContactViewController(for: contact)
            controller.delegate = self
            controller.contactStore = contactStore
            controller.allowsEditing = true
            controller.allowsActions = true
            
            controller.displayedPropertyKeys = [CNContactPhoneNumbersKey,CNContactEmailAddressesKey]
            
            self.navigationController?.pushViewController(controller, animated: true)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    //MARK: -- CNContactViewControllerDelegate
    //选中联系人属性时调用
    func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
        return true
    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        //更新修改后的contact
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
