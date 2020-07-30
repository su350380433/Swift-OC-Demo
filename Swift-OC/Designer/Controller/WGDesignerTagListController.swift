//
//  WGDesignerTagListController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/13.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit


class WGDesignerTagListController: WGTableViewController {
    
    var tagId : String?
    var tagname : String?
    
    var dataSource : Array<WGDesignerTagListDataItem>? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.tagname!
        self.tableView?.separatorStyle = .singleLine
        self.tableView?.frame = CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT), width: kMainScreenWidth, height: kMainScreenHeight-CGFloat(NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT))
        
        self.loadTagListData()
    }
    
    
//    convenience init(withTagId cId: NSInteger,tagname: NSString) {
//        self.init()
//        self.tagId = String(cId)
//        self.tagname = tagname as String
//
//    }
//
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: --------- UITableViewDelegate,UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "defalt")
        
        if cell == nil {
            cell = WGDesignerTagListCell.init(style: .default, reuseIdentifier: "defalt")
        }
        
        if indexPath.row < self.dataSource?.count ?? 0 {
            
            let model = self.dataSource?[indexPath.row]
            
            (cell as! WGDesignerTagListCell).authorAvatarImageV?.kf.setImage(with: URL(string: model?.userAvatar ?? ""))
            (cell as! WGDesignerTagListCell).authorNameLabel?.text = model?.userNick ?? ""
            (cell as! WGDesignerTagListCell).authorDesLabel?.text = model?.opTag ?? ""
            (cell as! WGDesignerTagListCell).authorTagLabel?.text = "简约"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func loadTagListData() -> Void{
        
        let dict = NSMutableDictionary()
        dict .setValue(self.tagId, forKey: "tagId")
        
        NetworkRequest(.designerTagsListApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let dataModel = WGDesignerTagListModel.deserialize(from: respose){
                if dataModel.code == SuccessCode {
                    self.dataSource = dataModel.data?.content!
                    
                }else{
                }
            }
        }
    }

}
