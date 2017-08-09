//
//  launchViewController.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/22.
//  Copyright © 2017年 JJing. All rights reserved.
//

import UIKit

class launchViewController: UIViewController {
    
    //Components
    //AR
    private let ARVC = ARViewController()
    
    //hamburger
    private let hamburgerButton = UIButton()
    
    //menu
    private let menuVC = menuViewController()
    private var menuLeadingConstraint : NSLayoutConstraint?
    
    //redDot
    private var redDot:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addARVC()
        self.addRedDot()
        self.addMenuVC()
        self.addHamburger()
    }
    
    //MARK: menu view methods
    private func addMenuVC()
    {
        self.view.addSubview(menuVC.view)
        self.setMenuViewConstraints()
    }
    
    //MARK: hamburger's methods
    private func addHamburger()
    {
        hamburgerButton.setImage(UIImage.init(named: "list"), for: .normal)
        hamburgerButton.addTarget(self, action: #selector(self.pressedHamburger), for: .touchUpInside)
        hamburgerButton.tag = 0
        self.view.addSubview(hamburgerButton)
        self.setHamburgerUIConstraints()
    }
    
    @objc private func pressedHamburger()
    {
        self.changeMenuLeadingConstraint(isExpand: hamburgerButton.tag==0)
        
        hamburgerButton.tag ^= 1
    }
    
    //MARK: ARViewController's methods
    private func addARVC()
    {
        self.view.addSubview(ARVC.view)
        setARVCFullScreenConstraints()
    }
    
    private func addRedDot()
    {
        redDot = UIImageView()
        redDot?.image = UIImage.init(named: "reddot")
        self.view.addSubview(redDot!)
        self.setRedDotConstraints()
    }
    
    //    @objc func removeTestTouch(_ sender: Any) {
    //        self.ARVC.removeFood()
    //    }
    
    //MARK: UI Constraints
    private func setRedDotConstraints()
    {
        redDot?.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint.init(item: redDot!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let height = NSLayoutConstraint.init(item: redDot!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let centerX = NSLayoutConstraint.init(item: redDot!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint.init(item: redDot!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraints([width, height, centerX, centerY])
    }
    private func setMenuViewConstraints()
    {
        menuVC.view.translatesAutoresizingMaskIntoConstraints = false;
        let width = NSLayoutConstraint(item: menuVC.view, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.35, constant: 0)
        
        let height = NSLayoutConstraint(item: menuVC.view, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: menuVC.view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        menuLeadingConstraint = NSLayoutConstraint(item: menuVC.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        
        
        self.view.addConstraints([width,height,centerY,menuLeadingConstraint!])
        
    }
    
    private func changeMenuLeadingConstraint(isExpand:Bool)
    {
        self.view.removeConstraint(menuLeadingConstraint!)
        if (isExpand)
        {
            menuLeadingConstraint = NSLayoutConstraint(item: menuVC.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            
        }else
        {
            menuLeadingConstraint = NSLayoutConstraint(item: menuVC.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        }
        self.view.addConstraint(menuLeadingConstraint!)
        //self.view.needsUpdateConstraints()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        //self.view.layoutSubviews()
        //self.view.setNeedsDisplay()
    }
    
    private func setARVCFullScreenConstraints()
    {
        ARVC.view.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint.init(item: ARVC.view, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint.init(item: ARVC.view, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let ARViewLeadingConstraint = NSLayoutConstraint.init(item: ARVC.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint.init(item: ARVC.view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraints([width, height, ARViewLeadingConstraint, centerY])
        
    }
    private func setHamburgerUIConstraints()
    {
        hamburgerButton.translatesAutoresizingMaskIntoConstraints = false;
        let width = NSLayoutConstraint(item: hamburgerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        let height = NSLayoutConstraint(item: hamburgerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        let leading = NSLayoutConstraint(item: hamburgerButton, attribute: .leading, relatedBy: .equal, toItem: menuVC.view, attribute: .trailing, multiplier: 1, constant: 20)
        let top = NSLayoutConstraint(item: hamburgerButton, attribute: .top, relatedBy: .equal, toItem: menuVC.view, attribute: .top, multiplier: 1, constant: 20)
        
        self.view.addConstraints([width,height,leading,top])
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



