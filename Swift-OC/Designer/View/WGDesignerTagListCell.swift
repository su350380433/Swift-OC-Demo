//
//  WGDesignerTagListCell.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/13.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGDesignerTagListCell: UITableViewCell {

    var authorAvatarImageV : UIImageView?//头像
    var authorNameLabel : UILabel?//昵称
    var authorDesLabel : UILabel?//昵称
    var authorTagLabel : UILabel?//描述
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.authorAvatarImageV = UIImageView.init(frame: CGRect.zero)
        self.authorAvatarImageV?.clipsToBounds = true
        self.authorAvatarImageV?.layer.cornerRadius = 30
        self.authorAvatarImageV?.layer.borderWidth = 1
        self.authorAvatarImageV?.layer.borderColor = UIColor.gray.cgColor
        
        self.authorNameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font:UIFont.systemFont(ofSize: 14))
        
        self.authorTagLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12))
       
        self.authorDesLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12))
        
        self.contentView.addSubview(self.authorAvatarImageV!)
        self.contentView.addSubview(self.authorNameLabel!)
        self.contentView.addSubview(self.authorTagLabel!)
        self.contentView.addSubview(self.authorDesLabel!)
        
        self.authorAvatarImageV?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        })
        
        self.authorNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(self.authorAvatarImageV!.snp.right).offset(15)
        
        })
        
        self.authorDesLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.authorNameLabel!.snp.bottom).offset(10)
            make.left.equalTo(self.authorNameLabel!)
        })
        
        self.authorTagLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalTo(self.authorNameLabel!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
