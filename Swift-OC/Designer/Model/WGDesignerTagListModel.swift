//
//  WGDesignerTagListModel.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/13.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGDesignerTagListModel: WGModel {

    var data : WGDesignerTagListDataModel?
    
    required init() {
    }
    
}

class WGDesignerTagListDataModel: WGModel {
    
    var content : Array<WGDesignerTagListDataItem>?
    
    
    required init() {
    }
    
    
}

class WGDesignerTagListDataItem: WGModel {

    var banner : String?
    var opTag : String?
    var productNum : String?
    var userNick : String?
    var userAvatar : String?
    
    required init() {
    }
    
}
