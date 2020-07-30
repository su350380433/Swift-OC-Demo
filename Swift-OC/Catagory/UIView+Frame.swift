//
//  UIView+Frame.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/4.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

extension UIView {
    
    var left : CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = left
            self.frame = frame
        }
        get {
           return self.frame.origin.x
        }
    }

    var right : CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var top : CGFloat {
        set {
            
            var frame = self.frame
            frame.origin.y = top
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom : CGFloat {
        
        set {
            
            var frame = self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
        
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var width : CGFloat {
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    
        get {
            return self.frame.size.width
        }
    }
    
    var height : CGFloat {
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
        get {
            return self.frame.size.height;
        }
    }
    
    var centerX : CGFloat {
        set {
            self.center = CGPoint.init(x: centerX, y: self.center.y)
        }
        
        get {
            return self.center.x;
        }
    }
    
    var centerY : CGFloat {
        set {
            self.center = CGPoint.init(x: self.center.x, y: centerY)
        }
        get {
            return self.center.y;
        }
    }
    
    
}


