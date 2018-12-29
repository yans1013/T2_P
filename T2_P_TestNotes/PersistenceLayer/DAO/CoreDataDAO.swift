//
//  CoreDataDAO.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/25.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDAO: NSObject{
    //MARK: -- Core Data Stack
    // 得到沙箱Documents路径
    lazy var applicationDocumentsDirectory:NSURL = {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        return urls.last! as NSURL
    }()
    
    //返回被管理对象模型
    lazy var mangedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle(for: CoreDataDAO.self).url(forResource: "CoreDataNotes", withExtension: "momd") else{
            fatalError("failed to find data model")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("failed to create model from file:\(modelURL)")
        }
//        let frameworkBundle = Bundle(for: CoreDataDAO.self)
//        let modelURL = frameworkBundle.url(forResource: "CoreDateNotes", withExtension: "momd")!
        return mom
    }()
    
    //返回持久化存储协调器
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.mangedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("CoreDataNote.sqlite")
        
        do{
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            
        }catch{
            NSLog("%@", "SQlite数据加载失败")
            exit(0)
        }
        return coordinator
    }()
    
    //返回管理上下文对象
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    //MARK: -- 保存数据
    func saveContext(){
        if managedObjectContext.hasChanges{
            do{
                try managedObjectContext.save()
            }catch{
                let nserror = error as NSError
                NSLog("数据保存错误:%@", nserror)
                exit(0)
            }
        }
    }
    
    
}
