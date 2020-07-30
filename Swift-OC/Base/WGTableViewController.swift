//
//  WGTableViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/29.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGTableViewController: WGViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView : UITableView?
    var numberOfRow : NSInteger = 0
    public var style : NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if #available(iOS 11.0, *) {
            self.tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.initTableView()
     
    }
    
    func initTableView() -> Void {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT), width: kMainScreenWidth, height: IPHONE_CONTENT_HEIGHT), style: UITableView.Style(rawValue: style) ?? .plain)
        self.tableView?.separatorStyle = .none
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .onDrag
        self.tableView?.estimatedRowHeight = 0;
        self.tableView?.estimatedSectionHeaderHeight = 0;
        self.tableView?.estimatedSectionFooterHeight = 0;
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        return cell!
    }

}
