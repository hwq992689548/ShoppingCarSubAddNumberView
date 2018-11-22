//
//  MHSubAddView.swift
//  MHAddNumber
//
//  Created by 鲜恬科技 on 2018/11/20.
//  Copyright © 2018年 鲜恬科技. All rights reserved.
//

import UIKit

class MHSubAddView: UIView {

    var minValue: NSInteger = 0
    var maxValue: NSInteger = 100
    
    
    var minBtn = UIButton()  //只作展示
    var addBtn = UIButton()  //只作展示
    var textField = UITextField()
    
    var bkgView = UIView() //背景
    
    var leftBtn = UIButton() //左侧减
    var rightBtn = UIButton()  //右侧加
    
    var animationView = UIButton() //动画展开VIew
    var margin: UIEdgeInsets! //内边距
    var targetFrame: CGRect! //动画目的frame
    var orginFrame: CGRect! //源frmae
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.orginFrame = frame
        self.bkgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.bkgView.backgroundColor = UIColor.groupTableViewBackground
        self.bkgView.layer.cornerRadius = frame.size.height/2
        self.bkgView.layer.masksToBounds = true
        self.addSubview(self.bkgView)
        
        let ww = self.frame.size.width/3
        
        //减 只作展示
        self.minBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: ww, height: frame.size.height))
        self.minBtn.setTitle(" -", for: UIControl.State.normal)
        self.minBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)

        self.bkgView.addSubview(self.minBtn)
        
        
        //输入框
        self.textField = UITextField.init(frame: CGRect.init(x: ww, y: 0, width: ww, height: frame.size.height))
        self.textField.backgroundColor = UIColor.clear
        self.textField.returnKeyType = .done
        self.textField.textAlignment = .center
        self.textField.keyboardType = .asciiCapableNumberPad
        self.textField.delegate = self
        self.textField.addTarget(self , action: #selector(self.textFieldEditingEnd(textField:)), for: UIControl.Event.editingDidEnd)
        self.bkgView.addSubview(self.textField)
        
        //加 只作展示
        self.addBtn = UIButton.init(frame: CGRect.init(x: ww*2, y: 0, width: ww, height: frame.size.height))
        self.addBtn.setTitle("+ ", for: UIControl.State.normal)
        self.addBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.bkgView.addSubview(self.addBtn)
        
        
        //真正的加减事件
        self.leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: ww , height: frame.size.height))
        self.leftBtn.addTarget(self , action: #selector(leftBtnAction), for: UIControl.Event.touchUpInside)
        self.addSubview(self.leftBtn)

        self.rightBtn = UIButton.init(frame: CGRect.init(x: ww*2, y: 0, width: ww , height: frame.size.height))
        self.rightBtn.addTarget(self , action: #selector(rightBtnAction), for: UIControl.Event.touchUpInside)
        self.addSubview(self.rightBtn)
        self.textField.text = String(format: "%d", self.minValue)

    }
    
    
    /// 设置内边距
    ///
    /// - Parameter margin:
    func setMarginLayout(margin: UIEdgeInsets) {
        self.margin = margin
        let ww = (self.frame.size.width - (margin.left + margin.right))/3
        let hh = self.frame.size.height - margin.top - margin.bottom
        
        self.bkgView.frame = CGRect.init(x: margin.left, y: margin.top, width: frame.size.width - margin.left-margin.right, height: hh)
        self.bkgView.layer.cornerRadius = self.bkgView.frame.size.height/2
        self.bkgView.layer.masksToBounds = true

        self.minBtn.frame = CGRect.init(x: 0, y: 0, width: ww , height: hh)
        self.textField.frame = CGRect.init(x: ww , y: 0, width: ww , height: hh)
        self.addBtn.frame = CGRect.init(x: ww*2, y: 0, width: ww , height: hh)
        
        //真正的加减事件
        self.leftBtn.frame =  CGRect.init(x: 0, y: 0, width: ww + margin.left , height: frame.size.height)
        self.rightBtn.frame = CGRect.init(x: ww*2 + margin.left, y: 0, width: ww + margin.right , height: frame.size.height)
    }
    
    
    
    /// 动画展开 初始化
    func setInitialAnimation(toFrame: CGRect)  {
        self.targetFrame = toFrame
        self.animationView = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.animationView.layer.cornerRadius = self.frame.size.height/2
        self.animationView.layer.masksToBounds = true
        self.animationView.backgroundColor = UIColor.white
        self.animationView.setTitle("+", for: UIControl.State.normal)
        self.animationView.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.animationView.addTarget(self , action: #selector(animationViewStartAction), for: UIControl.Event.touchUpInside)
        self.addSubview(self.animationView)
        
    }
    
    @objc func animationViewStartAction(){
        self.animationViewStar(animationFlag: true)
        self.rightBtnAction()
    }
    
    
    /// 展开动画
    @objc func animationViewStar(animationFlag: Bool) {
        if animationFlag {
            self.setMarginLayout(margin: self.margin)
            self.animationView.alpha = 0
            
            //开始动画
            UIView.animate(withDuration: 0.2, animations: {
                self.animationView.alpha = 0
                self.frame.origin.x = self.targetFrame.origin.x
                self.frame.size.width = self.targetFrame.size.width
                self.setMarginLayout(margin: self.margin)
                
            }) { (flag) in
                self.frame = self.targetFrame
            }
        }else{
            self.animationView.alpha = 0
            self.frame.origin.x = self.targetFrame.origin.x
            self.frame.size.width = self.targetFrame.size.width
            self.setMarginLayout(margin: self.margin)
            self.frame = self.targetFrame
        }
    }
    
    
    
    /// 关闭动画
    @objc func closeAnimation(animationFlag: Bool){
        self.setMarginLayout(margin: self.margin)
        self.animationView.alpha = 0
        
        //开始动画
        UIView.animate(withDuration: 0.2, animations: {
            self.animationView.alpha = 1
            self.frame.origin.x = self.orginFrame.origin.x
            self.frame.size.width = self.orginFrame.size.width
            self.setMarginLayout(margin: self.margin)
        }) { (flag) in
            self.frame = self.orginFrame
        }
    }
    
    
    
    
    /// 减
    @objc func leftBtnAction(){
        print("--")
        var num = NSInteger(self.textField.text!)
        if num! <= self.minValue {
            return
        }
        num = num! - 1
        self.textField.text =  String(format: "%d", num!)
        if num == 0 {
            self.closeAnimation(animationFlag: true)
        }
    }
    
    
    /// 加
    @objc func rightBtnAction(){
        print("++")
        var num = NSInteger(self.textField.text!)
        if num! >= self.maxValue {
            return
        }
        num = num! + 1
        self.textField.text =  String(format: "%d", num!)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func textFieldEditingEnd(textField: UITextField) {
        let num = NSInteger(self.textField.text!)
        if num == 0 {
            self.endEditing(true)
            self.closeAnimation(animationFlag: true)
        }
    }
    
}


extension MHSubAddView: UITextFieldDelegate {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            self.endEditing(true)
        }
        return true
    }
    
}
