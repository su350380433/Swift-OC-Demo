//
//  WGDesingerTagCell.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

typealias SelectTagItemBlock = (_ index: NSInteger) -> Void

class WGDesingerTagCell: UITableViewCell {

    var leftTagView : WGDesingerTagView?
    var rightTagView : WGDesingerTagView?
    var selectTagItemBlock : SelectTagItemBlock?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.leftTagView = WGDesingerTagView.init(frame: CGRect.zero)
        self.rightTagView = WGDesingerTagView.init(frame: CGRect.zero)
        
        self.contentView.addSubview(self.leftTagView!)
        self.contentView.addSubview(self.rightTagView!)
     
        self.leftTagView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView).offset(2)
            make.left.bottom.equalTo(self.contentView)
            make.width.equalTo(kMainScreenWidth / 2 - 1)
        })
   
        self.rightTagView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView).offset(2)
            make.right.bottom.equalTo(self.contentView)
            make.width.equalTo(kMainScreenWidth / 2 - 1)
        })
        
        self.leftTagView?.maskLayerView?.addTarget(self, action: #selector(self.selectLeftTagItem(_ :)), for: .touchUpInside)
        self.rightTagView?.maskLayerView?.addTarget(self, action: #selector(self.selectRightTagItem(_ :)), for: .touchUpInside)
    }
    
    @objc func selectLeftTagItem(_ sender : UIControl) -> Void {
        
        if self.selectTagItemBlock != nil {
            self.selectTagItemBlock?(0)
        }
    }
    
    @objc func selectRightTagItem(_ sender : UIControl) -> Void {
        
        if self.selectTagItemBlock != nil {
            self.selectTagItemBlock?(1)
        }
    }
    
    
    func loadUI(leftModel : WGDesignerTagsItem, rightModel : WGDesignerTagsItem) -> Void {
        
        self.leftTagView?.contentImageV?.kf.setImage(with: URL.init(string: leftModel.image!))
        self.leftTagView?.titleLabel?.text = leftModel.name
    
        self.rightTagView?.contentImageV?.kf.setImage(with: URL.init(string: rightModel.image!))
        self.rightTagView?.titleLabel?.text = rightModel.name
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        
    }

}


class WGDesingerTagView: UIControl {
    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?
    var maskLayerView : UIControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.contentImageV?.isUserInteractionEnabled = true
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font:UIFont.systemFont(ofSize: 16))
        self.maskLayerView = UIControl.init(frame: CGRect.zero)
        self.maskLayerView?.backgroundColor = UIColor.black
        self.maskLayerView?.alpha = 0.3
        self.addSubview(self.contentImageV!)
        self.addSubview(self.maskLayerView!)
        self.addSubview(self.titleLabel!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        self.maskLayerView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentImageV!)
        })
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

