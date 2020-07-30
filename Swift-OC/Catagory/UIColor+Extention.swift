//
//  UIColor+Extention.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/25.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {

    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0) {
        self.init(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:alpha)
    }
    
    /// 计算属性：只读属性
    class var randomColor : UIColor{
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    func getRGB() -> (CGFloat,CGFloat,CGFloat) {
        var red     :CGFloat = 0
        var green   :CGFloat = 0
        var blue    :CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255,green * 255,blue * 255)
        
    }
}
