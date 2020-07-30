//
//  WGDesignerHeaderView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGDesignerHeaderView: UIControl {
    
    var contentImageV : UIImageView?
    var maskBackView : UIView?
    var titleLabel : UILabel?
    var cutLine : UIView?
    var nameLabel : UILabel?
    var describeLabel : UILabel?
    var tagLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.maskBackView = UIView()
        self.maskBackView?.backgroundColor = UIColor.black
        self.maskBackView?.alpha = 0.5
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 16))
        self.cutLine = UIView.init(frame: CGRect.zero)
        self.cutLine?.backgroundColor = UIColor.white
        self.nameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 14))
        self.tagLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12))
        self.describeLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 16))
        
        self.addSubview(self.contentImageV!)
        self.addSubview(self.maskBackView!)
        self.addSubview(self.titleLabel!)
        self.addSubview(self.cutLine!)
        self.addSubview(self.nameLabel!)
        self.addSubview(self.tagLabel!)
        self.addSubview(self.describeLabel!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
            make.top.equalTo(self).offset(CGFloat(-STATUS_BAR_HEIGHT))
        })
        
        self.maskBackView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentImageV!)
            make.top.equalTo(self).offset(CGFloat(-STATUS_BAR_HEIGHT))
        }
        
        self.tagLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(self).offset(15)
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.tagLabel!.snp.top).offset(-15)
            make.left.equalTo(self.tagLabel!)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.nameLabel!.snp.top).offset(-8)
            make.left.equalTo(self.tagLabel!)
        })
        
        self.cutLine?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.titleLabel!.snp.right).offset(8)
            make.centerY.equalTo(self.titleLabel!)
            make.size.equalTo(CGSize.init(width: 1, height: 20))
        })
        
        self.describeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.titleLabel!)
            make.left.equalTo(self.cutLine!.snp.right).offset(8)
        })
    }
    
    func loadUI(model:WGDesignerRecommendDataModel) -> Void {
     
        self.contentImageV?.kf.setImage(with: URL.init(string: model.banner!))
        var tagString = ""
        
        for tagItem in model.tags! {
            tagString = tagString + tagItem.name!
        }
        self.tagLabel?.text = tagString
        self.nameLabel?.text = model.opTag
        self.titleLabel?.text = model.userNick
        self.describeLabel?.text = model.shopName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
