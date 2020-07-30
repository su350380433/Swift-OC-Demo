//
//  WGDesignerRecommendModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGDesignerRecommendModel: WGModel {

    var data : WGDesignerRecommendDataModel?
    required init() {
    }
}

class WGDesignerRecommendDataModel: HandyJSON {
    
    var banner : String?
    var fansNum : NSInteger?
    var id : NSInteger?
    var intro : String?
    var isFollow : Bool?
    var items : Array<Any>?
    var opTag : String?
    var products : Array<Any>?
    var productNum : NSInteger?
    var shareUrl : String?
    var shopId : String?
    var shopName : String?
    var tags : Array<WGDesignerRecommendTagsModel>?
    
    var userAvatar : String?
    var userId : NSInteger?
    var userNick : String?
    
    required init() {
    }
}

class WGDesignerRecommendTagsModel: HandyJSON {
    
    var categoryId : NSInteger?
    var id : NSInteger?
    var image : String?
    var name : String?
    required init() {
    }
}


struct Modelllll {
    var categoryId : String?
  
    var name : String?
   
}
