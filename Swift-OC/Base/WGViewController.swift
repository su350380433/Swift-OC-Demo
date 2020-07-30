//
//  WGViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit


class WGViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
        self.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.view.backgroundColor = UIColor.white

    }
    
    /// 状态栏状态
    public var statusBarStyle : UIStatusBarStyle = .lightContent {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func setStatusBarBackground(color : UIColor) -> Void {
        let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as! UIView).value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = color;
    }
    
    
    public func setNavigatonLeftItem(_ leftImageName : String) -> Void {
        // 左侧按钮
        let rightBtn = UIButton.creatButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20), target: self, action: #selector(leftBtnClick(_ :)), bgImage: UIImage.init(named: ""))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
    }
    
    public func setNavigatonRightItem(_ rightImageName : String) -> Void {
        // 右侧按钮
        let rightBtn = UIButton.creatButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20), target: self, action: #selector(rightBtnClick(_ :)), bgImage: UIImage.init(named: "icn_msg_white"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
    }
    
    //MARK: --------- Private
    
    @objc func rightBtnClick(_ button : UIButton) -> Void {
        
    }
    @objc func leftBtnClick(_ button : UIButton) -> Void {
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
}
