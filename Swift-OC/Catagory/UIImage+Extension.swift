//
//  UIImage+Extension.swift
//  LaiHua
//
//  Created by Muyuli on 2018/12/19.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func tabBarItem(imageUrl : String) -> UIImage {
        
        let stringArr = imageUrl.components(separatedBy: "/")
        var imageName = stringArr.last
        let name = imageName?.components(separatedBy: ".").first
        imageName = name! + "@3x.png"
       
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.localDomainMask, true).last

        let iconFilePath = path! + "/" + "tabbarIcons"
        let fullPath = iconFilePath + "/" + imageName!
        
        // 判断文件是否已存在，存在直接读取
        if FileManager.default.fileExists(atPath: fullPath) {
            return UIImage.init(contentsOfFile: fullPath)!
        }
      
        do {
            
            //创建iconFilePath文件
            let existed = FileManager.default.fileExists(atPath: iconFilePath)
            if existed == false {
                creatFilePath(path: iconFilePath)
            }
            
            let array = try FileManager.default.contentsOfDirectory(atPath: iconFilePath)
            if array.count >= 8{
                try FileManager.default.removeItem(atPath: iconFilePath)
            }
            
            let data = try NSData.init(contentsOf: URL.init(string: imageUrl)!, options: NSData.ReadingOptions.mappedIfSafe) as Data
            
            let image = UIImage.init(data: data)
            let imageData = image!.pngData()
            try imageData!.write(to: URL.init(fileURLWithPath: fullPath), options: [.atomic])
        
            return UIImage.init(contentsOfFile: fullPath)!
        
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        return UIImage()
    }
    
}
