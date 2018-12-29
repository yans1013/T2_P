//
//  DetailViewController.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //逻辑层对象
    var bl = NoteBussLogic()
    
   @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        let note = Note()
        note.date = Date()
        note.content = self.detailTextView.text
        let relist = bl.modify(model: note)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTextViewNotification"), object: relist, userInfo: nil)
        self.detailTextView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.detailTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func configureView() {
      // Update the user interface for the detail item.
       if let detail:Note = self.detailItem as? Note {
           if let label = self.detailDescriptionLabel  {
                label.text = detail.content
                print(detail.date)
            }
            if let textView = self.detailTextView {
                textView.text = detail.content
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    var detailItem: Any? {
        didSet {
            // Update the view.
            configureView()

        }
    }



}

