//
//  WGDesingerSectionHeaderView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

typealias SelectSegmentItemBlock = (_ index : NSInteger) -> Void

class WGDesingerSectionHeaderView: UIView {

    var segmentControl : UISegmentedControl?
    
    var selectItemBlock : SelectSegmentItemBlock?
    
    var bottomLineView : UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.segmentControl = UISegmentedControl.init(items: ["行业","风格"])
        self.addSubview(self.segmentControl!)
        self.segmentControl?.tintColor = UIColor.clear
        self.segmentControl?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black,
                                                     NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),]
            , for: .normal)
        
        self.segmentControl?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : KMainColor,
                                                     NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),]
            , for: .selected)
        
        self.segmentControl?.selectedSegmentIndex = 0
        //当选中不同的segment时,会触发不同的点击事件
        self.segmentControl?.addTarget(self, action: #selector(self.selected(_ :)), for: .valueChanged)
        self.segmentControl?.snp.makeConstraints({ (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 150, height: 30))
        })
        
        self.bottomLineView = UIView.init(frame: CGRect.zero)
        self.bottomLineView?.backgroundColor = KMainColor
        
    }

    @objc func selected(_ sender : UISegmentedControl) -> Void {
        
        if self.selectItemBlock != nil {
            self.selectItemBlock!(sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
