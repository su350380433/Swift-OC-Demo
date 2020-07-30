//
//  MineViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import Lottie

class WGMineViewController: WGTableViewController{
   
    let headerViewHeight : CGFloat = 250
    var headerView : WGMineHeaderView?
    var scrollOffsetY : CGFloat = 0
    
    var navigationBarAlpha : CGFloat? {
        didSet {
            self.navigationController?.navigationBar.alpha = navigationBarAlpha ?? 0
            self.navigationController?.navigationBar.isHidden = (navigationBarAlpha == 0)
        }
    }
    
    var dataSource : Array<WGMineShoppingTagModel>?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationBarAlpha = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationBarAlpha = 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        self.navigationItem.title = "我的"
        self.tableView?.frame = CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight - CGFloat(TAB_BAR_HEIGHT))
        self.tableView?.separatorStyle = .singleLine
        self.tableView?.backgroundColor = .clear
        self.initHeaderView()
        self.tableView?.register(WGMineShoppingCell.self, forCellReuseIdentifier: "WGMineShoppingCell")
        self.tableView?.register(WGMineCommonCell.self, forCellReuseIdentifier: "WGMineCommonCell")
        
        //注册OC的cell
        self.tableView?.register(MineAboutCell.self, forCellReuseIdentifier: "MineAboutCell")

        self.initDataSource()
        
        
        /*
         let starAnimationView = AnimationView(name: "8795-beach-cabin")
         starAnimationView.frame = .init(x: 0, y: 0, width: 200, height: 200)
         starAnimationView.center = self.view.center
         starAnimationView.contentMode = .scaleAspectFit
         starAnimationView.loopMode = LottieLoopMode.loop
         self.view.addSubview(starAnimationView)
         starAnimationView.play { (finished) in
         
         }
         */
        
    }

    
    func initDataSource() -> Void {
        
        self.dataSource = WGMineShoppingTagModel.initDataSource()
        
    }
    
    func initHeaderView() -> Void {
        self.headerView = WGMineHeaderView.init(frame: CGRect.init(x: 0, y:0, width: kMainScreenWidth, height: headerViewHeight))
        self.tableView?.tableHeaderView = self.headerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 44))
            view.backgroundColor = .clear
            let label = UILabel.createLabel(frame: CGRect.init(x: 15, y: 0, width: 100, height: 44), text: "TA说", textColor: grayColor, font: font14, backColor: .clear, textAlignment: .left)
            view.addSubview(label)
            return view
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 44
        default:
            return 10
        }
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WGMineShoppingCell")
        cell?.selectionStyle = .none
        if indexPath.section == 0 {
            (cell as! WGMineShoppingCell).loadItems(self.dataSource)
        }else if indexPath.section == 3 {
            
            let aboutCell = tableView.dequeueReusableCell(withIdentifier: "MineAboutCell")
            aboutCell?.accessoryType = .disclosureIndicator
            aboutCell?.textLabel?.textColor = .red;
            aboutCell?.textLabel?.text = "这个是OC写的cell"
        
            return aboutCell!
            
        } else {
            let commonCell = tableView.dequeueReusableCell(withIdentifier: "WGMineCommonCell")
            commonCell?.accessoryType = .disclosureIndicator
            if indexPath.section == 1 {
                
                (commonCell as! WGMineCommonCell).titleLabel?.text = "0 已喜欢"
                (commonCell as! WGMineCommonCell).imageView?.image = UIImage.init(named: "icn_myfav")
            }else if indexPath.section == 2 {
                if indexPath.row == 0 {
                    (commonCell as! WGMineCommonCell).titleLabel?.text = "意见反馈"
                    (commonCell as! WGMineCommonCell).imageView?.image = UIImage.init(named: "icn_feedback")
                }else {
                    (commonCell as! WGMineCommonCell).titleLabel?.text = "设置"
                    (commonCell as! WGMineCommonCell).imageView?.image = UIImage.init(named: "icn_settings")
                }
            }
            
            return commonCell!
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        }
        return 44
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset : CGFloat = scrollView.contentOffset.y
        print(yOffset)
     
        let height = CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
        
        // 下拉 纵向偏移量变小 变成负的
        if yOffset < 0 {
            // 拉伸后图片的高度
            let totalOffset = self.headerViewHeight - yOffset;
            // 图片放大比例
            let scale = totalOffset / self.headerViewHeight;
            // 拉伸后图片位置
            self.headerView?.contentImageV!.frame = CGRect.init(x: -(kMainScreenWidth * scale - kMainScreenWidth) / 2, y: yOffset, width: kMainScreenWidth * scale, height: totalOffset)
        }else if yOffset > 0 && yOffset <= height{
            
            let alpha = yOffset / height
            self.navigationBarAlpha = alpha
        }
        
        self.scrollOffsetY = yOffset
      
    }
    
    

}
