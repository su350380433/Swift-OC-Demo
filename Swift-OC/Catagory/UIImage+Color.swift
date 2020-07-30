//
//  UIImage+Color.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/5.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    class func initImage(color : UIColor) -> UIImage {
        
        var image = UIImage()
        if let ctx = UIGraphicsGetCurrentContext() {
            let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
            ctx.setFillColor(color.cgColor)
            ctx.setStrokeColor(color.cgColor)
            ctx.addRect(rect)
            ctx.drawPath(using: .fillStroke)
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return image
    }
    
    //将图片缩放成指定尺寸（多余部分自动删除）
    func scaled(newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    
}



