//
//  FileManager+handle.swift
//  LaiHua
//
//  Created by Muyuli on 2018/12/20.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation

func isFileExists(path : String) {
    
    let result = FileManager.default.fileExists(atPath: path)
    
    if result {
             print("true")
    }else{
        print("false")
    }
}

func creatFilePath(path:String){
    
    do{
        // 创建文件夹 1，路径 2 是否补全中间的路劲 3 属性
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil) //创建文件
      
    } catch{
        print("creat false")
    }
}


func removeFilePath(path:String){
    
    do{
        try FileManager.default.removeItem(atPath: path)
    } catch {
        
        print("creat false")
    }
}

