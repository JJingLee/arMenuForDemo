//
//  menuViewController.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/22.
//  Copyright © 2017年 JJing. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let bgView = UIView()
    private var hightlightColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialBGView()
        initialScrollView()
        styleSettings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let menuSize = self.getMenuList().count
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.width * 1.25 * CGFloat(menuSize))
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.setMenuItemsConstraints()
        
    }
    //MARK: initial configs
    private func styleSettings()
    {
        self.view.backgroundColor = .clear
        self.bgView.backgroundColor = .black
        self.bgView.alpha = 0.5
        self.scrollView.backgroundColor = .clear
    }
    
    //MARK: views config functions
    private func initialScrollView()
    {
        scrollView.delegate = self
        
//        let aView = UIView(frame: CGRect.init(x: 10, y: 10, width: 20, height: 20))
//        aView.backgroundColor = UIColor.brown
//        self.scrollView.addSubview(aView)
        self.view.addSubview(scrollView)
        self.setScrollViewConstraints()
    }
    
    private func initialBGView()
    {
        self.view.addSubview(bgView)
        self.setBackgroudViewConstraints()
    }
    
    private func getMenuList()->[menuObj]
    {
        return menuModel.shareInstance().getMenu()
    }
    
    //MARK: UI constraints
    private func setBackgroudViewConstraints()
    {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: bgView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier:1, constant: 0)
        let height = NSLayoutConstraint(item: bgView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: bgView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: bgView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.view.addConstraints([width,height,centerX, centerY])
    }
    private func setScrollViewConstraints()
    {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier:1, constant: 0)
        let height = NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.view.addConstraints([width,height,centerX, centerY])
    }
    private func setMenuItemsConstraints()
    {
        var index = 0
        var lastItemView : menuItemView?
        for item in self.getMenuList()
        {
            let itemView = menuItemView()
            itemView.initialWith(id: item.objId, name: item.productName, imageName: item.productImageName)
            itemView.hightlightColor = .white
            //itemView.frame = CGRect(x: 0, y: self.scrollView.frame.width * CGFloat(1.25) * CGFloat(index), width: self.scrollView.frame.width, height: self.scrollView.frame.width * CGFloat(1.25))
            scrollView.addSubview(itemView)
            
            //constraints
            itemView.translatesAutoresizingMaskIntoConstraints = false
            let width = NSLayoutConstraint(item: itemView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: itemView, attribute: .height, relatedBy: .equal, toItem: itemView, attribute: .width, multiplier: 1.25, constant: 0)
            var top : NSLayoutConstraint?
            if index == 0
            {
                top = NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
            }else{
                top = NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: lastItemView, attribute: .bottom, multiplier: 1, constant: 0)
            }
            let centerX = NSLayoutConstraint(item: itemView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0)
            
            scrollView.addConstraints([width, height, top! ,centerX])
            
            lastItemView = itemView
            index += 1
        }
    }
    
    
    //MARK: scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //disable horicental scroll
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
