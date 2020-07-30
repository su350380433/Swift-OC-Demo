//
//  WGMineHeaderView.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/23.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGMineHeaderView: UIView {

    var contentImageV : UIImageView?

    var tipLabel : UILabel?
    var loginLButton : UILabel?
    
    var followValueLabel : UILabel?//关注
    var followedValueLabel : UILabel?//粉丝
    var followLabel : UILabel?//关注
    var followedLabel : UILabel?//粉丝

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.contentImageV?.image = UIImage.init(named: "img_bg")
        self.tipLabel = UILabel.createLabel(frame: CGRect.zero, text: "在这里，找到属于你的不一样", textColor: grayColor, font: UIFont.systemFont(ofSize: 16))
       
        self.loginLButton = UILabel.createLabel(frame: CGRect.zero, text: "登录/注册", textColor: .white, font: UIFont.systemFont(ofSize: 16))
        
        self.followValueLabel = UILabel.createLabel(frame: CGRect.zero, text: "0", textColor: .white, font: UIFont.systemFont(ofSize: 13))
        self.followedValueLabel = UILabel.createLabel(frame: CGRect.zero, text: "0", textColor: .white, font: UIFont.systemFont(ofSize: 13))
        self.followLabel = UILabel.createLabel(frame: CGRect.zero, text: "关注", textColor: .gray, font: UIFont.systemFont(ofSize: 12))
        self.followedLabel = UILabel.createLabel(frame: CGRect.zero, text: "粉丝", textColor: .gray, font: UIFont.systemFont(ofSize: 12))
        
        
        let line = UIView.init(frame: .zero)
        line.backgroundColor = grayLineColor
        
        self.addSubview(self.contentImageV!)
        self.addSubview(self.tipLabel!)
        self.addSubview(self.loginLButton!)
        
        self.addSubview(self.followValueLabel!)
        self.addSubview(self.followedValueLabel!)
        self.addSubview(self.followLabel!)
        self.addSubview(self.followedLabel!)
        self.addSubview(line)
        
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
            make.top.equalTo(self).offset(CGFloat(-STATUS_BAR_HEIGHT))
        })
        
        self.tipLabel?.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self).offset(100)
        }
        
        self.loginLButton?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.tipLabel!.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        })
        
        
        self.followLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(self).offset(15)
        })
        
        self.followValueLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.followLabel!.snp.top).offset(-5)
            make.left.equalTo(self).offset(15)
        })
        
        line.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(self).offset(60)
            make.height.equalTo(35)
            make.width.equalTo(1)
        })
        
        self.followedLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo(line).offset(15)
        })
        
        self.followedValueLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.followedLabel!.snp.top).offset(-5)
            make.left.equalTo(line).offset(15)
        })
        
  
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
    

}
