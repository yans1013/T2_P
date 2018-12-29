//
//  NoteBussLogic.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/21.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import Foundation

struct NoteBussLogic{
   let dao = NoteDAOCD.sharedInstance
    //插入数据
    func create(model:Note)-> NSMutableArray{
        dao.create(model: model)
        return dao.findAll()!
    }
    
    //删除数据
    func remove(model: Note) -> NSMutableArray{
        dao.remove(model: model)
        return dao.findAll()!
    }
    
    //查询所有数据
    func findAll() -> NSMutableArray{
        return dao.findAll()!
        
    }
    
    //修改数据
    func modify(model: Note) -> NSMutableArray{
        dao.modify(model: model)
        return dao.findAll()!
    }
}
