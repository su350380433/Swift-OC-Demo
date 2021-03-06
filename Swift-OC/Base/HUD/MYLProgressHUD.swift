//
//  MYLProgressHUD.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/24.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

enum MYLProgressHUDModel {
    case text //纯文本
    case customView //自定义
    case animationImage //动画组
    case circular //圆形
    case rectangle //矩形
    case chrysanthemum //菊花
}



class MYLProgressHUD: UIView {
    
    var cycyleTimer : Timer?
    open var currentView:UIView!
    open var hudMaskView:UIView!
    open var hudView:UIView!
    open var blurView:UIVisualEffectView!
    open var circularView:ProgressView!
    open var rectView:ProgressRectView!
    open var animationImageView:UIImageView!
    open var animationImageViewArr:[UIImage]!
    open var animationImageViewindex:Int = 0
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    
    //默认尺寸
    fileprivate var defaultHudSize:CGSize = CGSize(width: 150, height: 100)
    
    //hud的渐变动画
    fileprivate var hudAnimated:Bool = false
    
    // MARK:- 尺寸
    open var currentHudSize:CGSize = CGSize.zero {
        didSet{
            defaultHudSize = currentHudSize
            hudView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
            blurView.frame = CGRect(x: 0, y: 0, width:defaultHudSize.width, height: defaultHudSize.height)
            hudView.center = CGPoint(x:currentView.frame.size.width/2 , y: currentView.frame.size.height/2)
        }
    }
    
    // MARK:- 延时关闭
    open var afterDelay:CGFloat = 0.0 {
        didSet{
            hideView(afterDelay: afterDelay)
        }
    }
    
    // MARK:- 设置文字
    open var titleText:String = "" {
        didSet{
            if(self.mode == .text) {
                setupHudTitle(title: titleText)
            }else if ( self.mode == .chrysanthemum) {
                //设置菊花文字
                setupChrysanthemum(title: titleText)
            }
            
        }
    }
    
    
    // MARK:- 进度
    open var progress:CGFloat = 0.0 {
        didSet{
            
            if(self.mode == .circular) {
                if(progress < 1){
                    self.circularView.progress = progress
                }else{
                    hideView(afterDelay: 0)
                }
                
                
            }else if (self.mode == .rectangle) {
                if(progress < 1){
                    self.rectView.progress = progress
                }else{
                    hideView(afterDelay: 0)
                }
            }
        }
    }
    
    // MARK:- 类型
    open var mode:MYLProgressHUDModel = .text {
        didSet{
            if mode == .circular {
                self.setupcircularView()
            } else if mode == .rectangle {
                self.setupRectView()
            }
        }
    }
    
    // MARK:- tincolor
    open var hudColor:UIColor! {
        didSet{
            hudView.backgroundColor = hudColor
        }
    }
    // MARK:- maskColor
    open var maskColor:UIColor! {
        didSet{
            hudMaskView.backgroundColor = maskColor
        }
    }
    
    
    // MARK:- 定义image动画
    open var animationImage = [UIImage]() {
        didSet{
            if mode == .animationImage {
                setupAnimationImage(imgArr:animationImage)
            }
        }
    }
    
    // MARK:- 自定义任何View
    open var customView:UIView! {
        didSet{
            if mode == .customView {
                self.currentHudSize = CGSize(width: customView.frame.size.width, height: customView.frame.size.height)
                setupHudCustomView(view: customView)
            }
        }
    }
    
    
    
    // MARK:- 初始化方法
    class func showHUDAddedTo(_ view: UIView, animated: Bool)->Self {
        let hud = self.init()
        hud.hudAnimated = animated
        hud.currentView = view
        hud.setupMaskView()
        hud.setupHudView()
        return hud
    }
    
}

// MARK:- 设置UI
extension MYLProgressHUD {
    // MARK:- 设置蒙版
    func setupMaskView() {
        hudMaskView = UIView()
        currentView.addSubview(hudMaskView)
        hudMaskView.frame = CGRect(x: 0, y: 0, width: currentView.frame.size.width, height: currentView.frame.size.height)
        hudMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    // MARK:- 设置Hud
    func setupHudView() {
        hudView = UIView()
        hudMaskView.addSubview(hudView)
        hudView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
        hudView.center = hudMaskView.center
        hudView.layer.cornerRadius = 8
        hudView.layer.masksToBounds = true
        hudView.backgroundColor = UIColor.black
        
        //增加毛玻璃效果
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
        hudView.addSubview(blurView)
        
        if hudAnimated {
            hudView.alpha = 0.1
            UIView.animate(withDuration: 0.5, animations: {
                self.hudView.alpha = 1
                
            })
        }
    }
    
    // MARK:- 设置HudTitle
    func setupHudTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.8))
        
        hudView.addSubview(titleLabel)
        //如果设置了当前的大小
        if currentHudSize.width > 0 {
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentHudSize.width - 20 , height: currentHudSize.height - 20)
        }else {
            //限制计算大小
            let limitSize = CGSize(width: currentView.frame.size.width - 20, height: 100)
            let currentSize = self.getTextRectSize(text: title as NSString, font: UIFont.systemFont(ofSize: 15, weight:  UIFont.Weight(rawValue: 0.8)), size: limitSize)
            self.currentHudSize = CGSize(width: currentSize.size.width + 20 , height: currentSize.size.height + 20 )
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentSize.width , height: currentSize.height)
        }
        titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2)
    }
    
    // MARK:- 设置chrysanthemum
    func setupChrysanthemum(title: String) {
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.8))
        hudView.addSubview(titleLabel)
        //如果设置了当前的大小
        if currentHudSize.width > 0 {
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentHudSize.width - 20 , height: currentHudSize.height - 20)
            titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 + 25)
            hudView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 - 15)
        }else {
            //限制计算大小
            let limitSize = CGSize(width: currentView.frame.size.width - 20, height: 150)
            let currentSize = self.getTextRectSize(text: title as NSString, font: UIFont.systemFont(ofSize: 15, weight:  UIFont.Weight(rawValue: 0.8)), size: limitSize)
            self.currentHudSize = CGSize(width: currentSize.size.width + 20 , height: currentSize.size.height + 60 )
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentSize.width , height: currentSize.height)
            titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 + 20)
            
            hudView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 - 10)
        }
        
        
        
    }
    
    
    // MARK:- 设置自己定义的View
    func setupHudCustomView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.height)
        hudView.addSubview(view)
        view.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2)
    }
    
    // MARK:- 设置动画View
    func setupAnimationImage(imgArr: [UIImage]) {
        blurView.isHidden = true
        animationImageViewArr = imgArr
        animationImageView = UIImageView(image: imgArr[0])
        animationImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        currentHudSize =  CGSize(width: 100, height: 100)
        self.addCycleTimer()
        //imageView.highlightedAnimationImages = imgArr
        //imageView.animationImages = imgArr
        //imageView.animationDuration = 0.5
        //imageView.animationRepeatCount = LONG_MAX
        //imageView.startAnimating()
        self.setupHudCustomView(view: animationImageView)
    }
    
    // MARK:- 设置圆形进度条
    func setupcircularView() {
        circularView = ProgressView()
        circularView.progress = 0.0
        circularView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        circularView.backgroundColor = UIColor.white
        self.setupHudCustomView(view: circularView)
    }
    // MARK:- 设置矩形进度条
    func setupRectView() {
        rectView = ProgressRectView()
        rectView.progress = 0.0
        rectView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        rectView.backgroundColor = UIColor.white
        self.setupHudCustomView(view: rectView)
    }
    
}

// MARK:- 外部动作
extension MYLProgressHUD {
    func hideView(afterDelay: CGFloat) {
        let after =  TimeInterval(afterDelay)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.removeCycleTimer()
            self.hudMaskView.removeFromSuperview()
        })
    }
}

// MARK:- 其他方法
extension MYLProgressHUD {
    
    
    //计算文本尺寸
    func getTextRectSize(text: NSString,font: UIFont,size: CGSize) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
    // 添加定时器
    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval: 0.3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer!, forMode:RunLoop.Mode.common)
        
    }
    
    // 移除定时器
    fileprivate func removeCycleTimer() {
        // 从运行循环中移除
        cycyleTimer?.invalidate()
        cycyleTimer = nil
    }
    
    // 定时器的方法
    @objc fileprivate func scrollToNext() {
        let count = animationImageViewArr.count
        
        if animationImageViewindex == count - 1 {
            animationImageViewindex = 0
        }else{
            animationImageViewindex =  animationImageViewindex + 1
        }
        animationImageView.image = animationImageViewArr[animationImageViewindex]
    }
}


class ProgressRectView: UIView {
    // MARK:- 定义属性
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    // MARK:- 重写drawRect方法
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 创建贝塞尔曲线
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: rect.height/2, width: rect.width * progress, height: 5), cornerRadius: 2.5)
        // 绘制一条中心点的线
        //path.addLine(to: center)
        //path.close()
        // 设置绘制的颜色
        UIColor(white: 0.5, alpha: 0.8).setFill()
        // 开始绘制
        path.fill()
    }
    
}


class ProgressView: UIView {
    // MARK:- 定义属性
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    // MARK:- 重写drawRect方法
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 获取参数
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = rect.width * 0.5 - 3
        let startAngle = CGFloat(-(Double.pi / 2))
        let endAngle = CGFloat(2*(Double.pi / 2)) * progress + startAngle
        
        // 创建贝塞尔曲线
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        // 绘制一条中心点的线
        path.addLine(to: center)
        path.close()
        // 设置绘制的颜色
        UIColor(white: 0.5, alpha: 0.8).setFill()
        // 开始绘制
        path.fill()
    }
    
}
