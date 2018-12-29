//
//  AddViewController.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var noteTextView: UITextView!
    //逻辑层对象
    var bl = NoteBussLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noteTextView.delegate = self
        self.noteTextView.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNote(_ sender: Any) {
        let note = Note()
        note.date = Date()
        note.content = self.noteTextView.text
        let relist = bl.create(model: note)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTextViewNotification"), object: relist, userInfo: nil)
        self.noteTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelNote(_ sender: Any) {
        dismiss(animated: true) {
            NSLog("%@", "close")
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            noteTextView.resignFirstResponder()
            return false
        }
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
