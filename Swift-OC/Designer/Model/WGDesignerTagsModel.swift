//
//  WGDesignerTagsModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGDesignerTagsModel: WGModel {
    
    var data : Array<WGDesignerTagsDataModel>?
    required init() {
    }
}

class WGDesignerTagsDataModel: HandyJSON {
    
    var id : NSInteger?
    var name : String?
    var tags : Array<WGDesignerTagsItem>?
    
    required init() {
    }
}

class WGDesignerTagsItem: HandyJSON {
    var categoryId : NSInteger?
    var id : NSInteger?
    var image : String?
    var name : String?

    required init() {
    }
}
