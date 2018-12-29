//
//  NoteDAO.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import Foundation

class NoteDAO{
    
    //data list
    var listData: NSMutableArray!
    private var dateFormatter = DateFormatter()
    private var plistFilePath: String!
    //单例模式
    static let sharedInstance: NoteDAO = {
        var instance = NoteDAO()
        //add test data
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let d1 = dateFormatter.date(from: "2018-11-12 11:11:11")
//        let n1 = Note(date: d1!, content: "hahahahahaha")
//
//        let d2 = dateFormatter.date(from: "2018-11-14 12:13:14")
//        let n2 = Note(date: d1!, content: "hehehehehe")
//
//        //init
//        instance.listData = NSMutableArray()
//        instance.listData.add(n1)
//        instance.listData.add(n2)
        
        //初始化Documents目录中的属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        instance.dateFormatter.locale = Locale(identifier: "zh_CN")
        
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        
        return instance
    }()
    
    //初始化属性列表文件
    //判断沙箱Documents目录中是否存在NotesList.plist文件，如果不存在则从数据持久层资源目录中复制一个过去
    func createEditableCopyOfDatabaseIfNeeded(){
        let fileManager = FileManager.default
        let dbExit = fileManager.fileExists(atPath: self.plistFilePath)
        if !dbExit{
            let fBundle = Bundle(for: NoteDAO.self)
            let fBunldePath = fBundle.resourcePath! as NSString
            let defaultDBPath = fBunldePath.appendingPathComponent("NotesList.plist")
            
            do {
                //实现文件复制
                try fileManager.copyItem(atPath: defaultDBPath, toPath: self.plistFilePath)
            }catch{
                assert(false,"写入文件错误")
            }
            
            
        }
    }
    
    func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        
        let docPath = documentDirectory.lastObject as! NSString
        let path = docPath.appendingPathComponent("NotesList.plist")
        return path
    }
    
//    //属性闭包格式
//
//    let applicationDocumentsDirectoryFile:String = {
//        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
//
//        let docPath = documentDirectory.lastObject as! NSString
//        let path = docPath.strings(byAppendingPaths: ["NotesList.plist"]).last!
//        return path
//    }()
//
    
    //insert data
     func create(_ model: Note) -> Int {
//        self.listData.add(model)
        
        //读取制定路径下的plist
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        let strDate = self.dateFormatter.string(from: model.date)
        let dict = ["date":strDate,"content":model.content]
        array.add(dict)
        //写入数据到制定路径的plist
        array.write(toFile: self.plistFilePath, atomically: true)
        return 0
        
    }
    
    //remove data
    func remove(_ model: Note) ->Int {
//        for note in self.listData{
//            let compare_note = note as! Note
//            if compare_note.date == model.date{
//                self.listData.remove(compare_note)
//                return 1
//            }
//        }
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        for item in array{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //通过日期判断目标是否存在
            if date == model.date{
                array.remove(dict)
                //写入保存
                array.write(toFile: self.plistFilePath, atomically: true)
                return 1
            }
        }
        return 0
    }
    
    //modify data
    func modify(_ model: Note) ->Int {
//        for note in self.listData{
//            let mod_note = note as! Note
//            if mod_note.date == model.date{
//                mod_note.content = model.content
//                return 1
//            }
//        }
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        for item in array{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            if date == model.date{
                //更新数据
                dict.setValue(model.content, forKey: "content")
                //写入保存
                array.write(toFile: self.plistFilePath, atomically: true)
                return 1
            }
        }
        return 0
    }
    
    //select all dats
    func findAll() -> NSMutableArray {
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        let listData = NSMutableArray()
        for item in array{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            let note = Note(date: date, content: content)
            listData.add(note)
        }
        return listData
    }
    
    //edit data
    func findById(_ model: Note) -> Note?{
//        for note in self.listData{
//            let edit_note = note as! Note
//            if edit_note.date == model.date{
//                return edit_note
//            }
//        }
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        for item in array{
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            if date == model.date {
                let note = Note(date: date, content: content)
                return note
            }
        }
        return nil
    }
}

