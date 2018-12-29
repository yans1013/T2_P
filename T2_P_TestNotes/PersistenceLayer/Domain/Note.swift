//
//  File.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import Foundation

class Note{
    var date: Date
    var content: String?
  
    init() {
        self.date = Date()
        self.content = ""
    }
    
    init(date: Date,content:String) {
        self.date = date
        self.content = content
    }
    
    private func dateForamt(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from:date)
    }
    
}
