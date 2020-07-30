//
//  NSString+Extension.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/23.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    enum ValidaString {
        case email(_: String)
        case phoneNum(_: String)
        case carNum(_: String)
        case username(_: String)
        case password(_: String)
        case nickname(_: String)
        case URL(_: String)
        case IP(_: String)
        
        var isRight: Bool {
            var predicateStr:String!
            var currObject:String!
            switch self {
            case let .email(str):
                predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
                currObject = str
            case let .phoneNum(str):
                predicateStr = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
                currObject = str
            case let .carNum(str):
                predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
                currObject = str
            case let .username(str):
                predicateStr = "^[A-Za-z0-9]{6,20}+$"
                currObject = str
            case let .password(str):
                predicateStr = "^[a-zA-Z0-9]{6,20}+$"
                currObject = str
            case let .nickname(str):
                predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
                currObject = str
            case let .URL(str):
                predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
                currObject = str
            case let .IP(str):
                predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
                currObject = str
            }
            
            let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
            return predicate.evaluate(with: currObject)
        }
    }
    
}

extension String {
    
    
    func wg_heightForComment(_ fontSize: UIFont, _ width: CGFloat, _ LineSpacing: CGFloat) -> CGFloat {
        let font = fontSize
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
        paraph.lineSpacing = LineSpacing

        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle: paraph], context: nil)
        return ceil(rect.height)
    }
    
    func wg_widthForComment(_ fontSize: UIFont, _ height: CGFloat = 15) -> CGFloat {
        let font = fontSize
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func wg_heightForComment(_ fontSize: UIFont, _ width: CGFloat) -> CGFloat {
        let font = fontSize
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func wg_heightForComment(_ fontSize: UIFont, _ width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = fontSize
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
