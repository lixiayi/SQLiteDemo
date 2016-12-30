//
//  ViewController.swift
//  SQLiteDemo
//
//  Created by xiaoyi li on 2016/12/30.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var db:Connection! = nil
    let users = Table("users")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    

    @IBAction func insertActioin(_ sender: Any) {
        do {
            let insert = users.insert(name<-"nihao", email<-"stoicer@sina.com")
            try db.run(insert)
        } catch {
            print(error)
        }
        
    }
    @IBAction func deleteAction(_ sender: Any) {
        let xiaoyili = users.filter(id == 3)
        do {
            try db.run(xiaoyili.delete())
        } catch  {
            print(error)
        }
    }
    
    
    @IBAction func queryAction(_ sender: Any) {
        
        do {
            for user in try db.prepare(users) {
                print("id:\(user[id]), name:\(user[name]), email:\(user[email])")
            }
        } catch {
            
        }
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        // 把id为3的记录的name字段值由nihao修改为xiaoyili
        let nihao = users.filter(id == 3)
        
        do {
            try db.run(nihao.update(name<-name.replace("nihao", with: "xiaoyili")))
        } catch {
            print(error)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            db = try Connection(NSHomeDirectory() + "/Documents/db.sqlite3")
            try db.run(users.create{
                 t in
                t.column(id, primaryKey:true)
                t.column(name)
                t.column(email)
            })
        } catch  {
            print(error)
        }
        
        
    }



}

