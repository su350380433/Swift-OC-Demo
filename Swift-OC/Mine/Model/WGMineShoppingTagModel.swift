//
//  WGMineShoppingTagModel.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/24.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGMineShoppingTagModel: NSObject {
    
    var imageName : String?
    var title : String?
    
    
    class func initDataSource() -> Array<WGMineShoppingTagModel> {
        
        let titleNameArray = ["我的订单","购物车","我的优惠券","喜欢的好物","设计师入驻"]
        let imageNameArray = ["icn_profile_order_small","icn_profile_cart_small","icn_profile_coupon_small","icn_profile_fav_small","icn_profile_settle_small"]
        
        let dataSource = NSMutableArray()
        
        for (index, title) in titleNameArray.enumerated() {
            
            let tagModel = WGMineShoppingTagModel.init()
            tagModel.imageName = imageNameArray[index]
            tagModel.title = title
            
            dataSource.add(tagModel)
        }
        return dataSource as! Array<WGMineShoppingTagModel>
        
    }
    
}
