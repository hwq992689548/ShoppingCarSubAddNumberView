# ShoppingCarSubAddNumberView
购物车中的减加视图 带有margin内边距 防止误点

![图片描述](https://github.com/hwq992689548/ShoppingCarSubAddNumberView/blob/master/%E6%9C%AA%E5%91%BD%E5%90%8D.mov)

##
  self.view.backgroundColor = UIColor.groupTableViewBackground
  
  subAddView = MHSubAddView.init(frame: CGRect.init(x: 250, y: 300, width: 40, height: 40))
  
  subAddView.setMarginLayout(margin: UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5))  //内边距
  
  subAddView.setInitialAnimation(toFrame: CGRect.init(x: 250-140, y: 300, width: 140, height: 40))  //动画结束后的frame
  
  self.view.addSubview(subAddView)


