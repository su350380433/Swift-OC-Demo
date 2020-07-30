//
//  WGMineShoppingCell.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/24.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class WGMineCommonCell: UITableViewCell {

    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: .black, font:UIFont.systemFont(ofSize: 15))
        
        self.addSubview(self.contentImageV!)
        
        self.addSubview(self.titleLabel!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 16, height: 26))
            make.left.equalToSuperview().offset(15)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.contentImageV!.snp.right).offset(15)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class WGMineShoppingCell: UITableViewCell {

    
    let count = 3
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadItems(_ dataArray : Array<WGMineShoppingTagModel>?) -> Void {
        
        if dataArray!.isEmpty {
            return
        }
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        for (i,model) in dataArray!.enumerated() {
            
            //行
            let row : CGFloat = CGFloat(i / count)
            //列
            let col : CGFloat = CGFloat(i % count)
            
            let kItemWidth : CGFloat = kMainScreenWidth / 3
            let kItemHeight : CGFloat = 80
            
            let frame = CGRect.init(x: kItemWidth*col, y: kItemHeight*row, width: kItemWidth, height: kItemHeight)
            let tagItemView = WGMineShoppingTagView.init(frame: frame)
            tagItemView.titleLabel?.text = model.title
            tagItemView.contentImageV?.image = UIImage.init(named: model.imageName!)
            self.contentView.addSubview(tagItemView)
            
        }
        
    }

}


class WGMineShoppingTagView: UIControl {
    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: .black, font:UIFont.systemFont(ofSize: 15))
   
        self.addSubview(self.contentImageV!)

        self.addSubview(self.titleLabel!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.top.equalToSuperview().offset(15)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.contentImageV!.snp.bottom).offset(5)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
