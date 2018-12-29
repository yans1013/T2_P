//
//  NoteDaoCD.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/26.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import Foundation
import CoreData

class NoteDAOCD: CoreDataDAO{
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    
    public static let sharedInstance: NoteDAOCD = {
        let instance = NoteDAOCD()
        
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        instance.dateFormatter.locale = Locale(identifier: "zh_CN")
        
        return instance
    }()
    
    //查询所有数据
    func findAll() -> NSMutableArray?{
        let context = self.managedObjectContext
        //获得entity
        //        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        //        fetchRequest.entity = entity
        
        //排序描述类
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        //定义结果集排列顺序
        fetchRequest.sortDescriptors = sortDescriptors
        
        do{
            let listData = try context.fetch(fetchRequest)
            let resListData = NSMutableArray()
            
            if listData.count > 0 {
                for item in listData{
                    let mo = item as! NoteManagedObject
                    let note = Note(date: mo.date! as Date, content: mo.content!)
                    resListData.add(note)
                }
            }
            return resListData
            
        }catch{
            print("查询数据失败")
        }
        return nil
    }
    
    //条件查询，按主键查询
    func findById(model: Note) -> Note? {
        let context = self.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date as CVarArg)
        
        do{
            let listData = try context.fetch(fetchRequest)
            
            if listData.count > 0 {
                let mo = listData.first as! NoteManagedObject
                let note = Note(date: mo.date! as Date, content: mo.content!)
                return note
            }
            
        }catch{
            print("数据查询失败！")
        }
        return nil
    }
    
    //插入数据
    func create(model: Note) -> Int {
        let context = self.managedObjectContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! NoteManagedObject
        
        note.date = model.date as NSDate
        note.content = model.content
        
        //保存数据
        self.saveContext()
        
        return 0
    }
    
    //删除数据
    func remove(model: Note) -> Int {
        let context = self.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date as CVarArg)
        
        do{
            let listData = try context.fetch(fetchRequest)
            if listData.count > 0 {
                let note = listData.first as! NoteManagedObject
                context.delete(note)
                
                //保存数据
                self.saveContext()
            }
            
        }catch{
            print("删除数据失败！")
        }
        return 0
    }
    
    
    //修改数据
    func modify(model: Note) -> Int {
        let context = self.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date as CVarArg)
        do{
            let listData = try context.fetch(fetchRequest)
            if listData.count > 0 {
                let note = listData.first as! NoteManagedObject
                note.content = model.content
                
                //保存数据
                self.saveContext()
            }
        }catch{
            print("修改数据失败！")
        }
        return 0
    }
}
