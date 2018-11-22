//
//  ViewController.swift
//  MHAddNumber
//
//  Created by 鲜恬科技 on 2018/11/20.
//  Copyright © 2018年 鲜恬科技. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var subAddView:MHSubAddView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        subAddView = MHSubAddView.init(frame: CGRect.init(x: 250, y: 300, width: 40, height: 40))
        subAddView.setMarginLayout(margin: UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5))  //内边距
        subAddView.setInitialAnimation(toFrame: CGRect.init(x: 250-140, y: 300, width: 140, height: 40))  //动画结束后的frame
        self.view.addSubview(subAddView)
        
 
    }
}

