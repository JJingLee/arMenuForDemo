//
//  menuItemView.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/24.
//  Copyright © 2017年 JJing. All rights reserved.
//

import UIKit
import SceneKit

class menuItemView: UIView {
    //UI components
    private let topCube = UIView()
    private let titleCube = UIView()
    private let imageCube = UIView()
    private var foodNameLabel : UILabel?
    private var foodImageButton : UIButton?
    private var foodEdgeView  : UIView?
    
    //UI style
    var hightlightColor : UIColor?
    
    //data components
    var objId : Int?
    var foodImageName : String?
    var foodName : String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func initialWith(id : Int, name : String, imageName : String) {
        objId = id
        foodName = name
        foodImageName = imageName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.initUIComponents()
    }
    
    private func initUIComponents()
    {
        //add Top blank cube
        self.addTopCube()
        //add title cube
        self.addTitleCube()
        //add image cube
        self.addImageCube()
    }
    private func addTopCube()
    {
        
        self.addSubview(topCube)
        topCube.backgroundColor = UIColor.clear
        //add constraints
        topCube.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: topCube, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: topCube, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.1, constant: 0)
        let centerX = NSLayoutConstraint(item: topCube, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: topCube, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        self.addConstraints([width,height,centerX,top])
    }
    private func addTitleCube()
    {
        
        self.addSubview(titleCube)
        titleCube.backgroundColor = UIColor.clear
        //add titleCube constraints
        titleCube.translatesAutoresizingMaskIntoConstraints = false
        var width = NSLayoutConstraint(item: titleCube, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        var height = NSLayoutConstraint(item: titleCube, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.1, constant: 0)
        var centerX = NSLayoutConstraint(item: titleCube, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: titleCube, attribute: .top, relatedBy: .equal, toItem: topCube, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraints([width,height,centerX,top])
        
        //add titleLabel constraints
        self.foodNameLabel = UILabel()
        self.foodNameLabel?.text = self.foodName
        self.foodNameLabel?.font = UIFont(name: "Helvetica-Light", size: 16)
        self.foodNameLabel?.textAlignment = .center
        self.foodNameLabel?.numberOfLines = 2
        self.foodNameLabel?.textColor = hightlightColor
        titleCube.addSubview(self.foodNameLabel!)
        foodNameLabel?.translatesAutoresizingMaskIntoConstraints = false
        centerX = NSLayoutConstraint(item: self.foodNameLabel!, attribute: .centerX, relatedBy: .equal, toItem: titleCube, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self.foodNameLabel!, attribute: .centerY, relatedBy: .equal, toItem: titleCube, attribute: .centerY, multiplier: 1, constant: 0)
        width = NSLayoutConstraint(item: self.foodNameLabel!, attribute: .width, relatedBy: .equal, toItem: titleCube, attribute: .width, multiplier: 1, constant: 0)
        height = NSLayoutConstraint(item: self.foodNameLabel!, attribute: .height, relatedBy: .equal, toItem: titleCube, attribute: .height, multiplier: 0.1, constant: 0)
        titleCube.addConstraints([centerX, centerY])
    }
    private func addImageCube()
    {
        self.addSubview(imageCube)
        imageCube.backgroundColor = UIColor.clear
        //add imageCube constraints
        imageCube.translatesAutoresizingMaskIntoConstraints = false
        var width = NSLayoutConstraint(item: imageCube, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        var height = NSLayoutConstraint(item: imageCube, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0)
        var centerX = NSLayoutConstraint(item: imageCube, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: imageCube, attribute: .top, relatedBy: .equal, toItem: titleCube, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraints([width,height,centerX,top])
        
        //add food edge constraints
        foodEdgeView = UIView()
        foodEdgeView?.backgroundColor = hightlightColor
        foodEdgeView?.alpha = 0.3
        imageCube.addSubview(foodEdgeView!)
        foodEdgeView?.translatesAutoresizingMaskIntoConstraints = false
        width = NSLayoutConstraint(item: foodEdgeView!, attribute: .width, relatedBy: .equal, toItem: imageCube, attribute: .width, multiplier: 0.8, constant: 0)
        height = NSLayoutConstraint(item: foodEdgeView!, attribute: .height, relatedBy: .equal, toItem: imageCube, attribute: .height, multiplier: 0.8, constant: 0)
        centerX = NSLayoutConstraint(item: foodEdgeView!, attribute: .centerX, relatedBy: .equal, toItem: imageCube, attribute: .centerX, multiplier: 1, constant: 0)
        var centerY = NSLayoutConstraint(item: foodEdgeView!, attribute: .centerY, relatedBy: .equal, toItem: imageCube, attribute: .centerY, multiplier: 1, constant: 0)
        imageCube.addConstraints([width,height,centerY,centerX])
        
        //add image button constraints
        foodImageButton = UIButton()
        foodImageButton?.setBackgroundImage(UIImage.init(named: foodImageName!), for: .normal)
        foodImageButton?.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        foodImageButton?.tag = 0
        imageCube.addSubview(foodImageButton!)
        foodImageButton?.translatesAutoresizingMaskIntoConstraints = false
        width = NSLayoutConstraint(item: foodImageButton!, attribute: .width, relatedBy: .equal, toItem: foodEdgeView, attribute: .width, multiplier: 1, constant: -10)
        height = NSLayoutConstraint(item: foodImageButton!, attribute: .height, relatedBy: .equal, toItem: foodEdgeView, attribute: .height, multiplier: 1, constant: -10)
        centerX = NSLayoutConstraint(item: foodImageButton!, attribute: .centerX, relatedBy: .equal, toItem: foodEdgeView, attribute: .centerX, multiplier: 1, constant: 0)
        centerY = NSLayoutConstraint(item: foodImageButton!, attribute: .centerY, relatedBy: .equal, toItem: foodEdgeView, attribute: .centerY, multiplier: 1, constant: 0)
        imageCube.addConstraints([width,height,centerX,centerY])
        
    }
    
    //MARK: button event
    @objc func buttonPressed()
    {
        //UI handles
        foodImageButton?.tag ^= 1
        foodEdgeView?.alpha = foodImageButton?.tag==0 ? 0.3 : 1
        
        if foodImageButton?.tag == 1
        {
            let theObjInfo = menuModel.shareInstance().findFood(id: self.objId!)
            let foodScene = SCNScene(named: (theObjInfo?.arObjName)!)!
            arFoodModels.shareInstance().addFoodToArray(id: self.objId!, node: foodScene.rootNode.childNodes[0])
        }else
        {
            arFoodModels.shareInstance().removeFoodFromArray(id: self.objId!)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
