//
//  menuModel.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/24.
//  Copyright © 2017年 JJing. All rights reserved.
//

import Foundation

class menuModel: NSObject {
    static var instance : menuModel?
    private var menuArray : [menuObj] = []
    
    static func shareInstance()->menuModel
    {
        if instance == nil
        {
            instance = menuModel()
            instance?.setMenu(foodList: [
                menuObj.init(objId: 0, productName: "beef noodle", daeName: "art.scnassets/beafNoodle/beafNoodle.dae",imageName: "beafNoodle"),
                menuObj.init(objId: 1, productName: "chicken rice", daeName: "art.scnassets/chickenRice/chickenRice.dae",imageName: "chickenRice"),
                menuObj.init(objId: 2, productName: "coffee", daeName: "art.scnassets/ARK_COFFEE_CUP.scn",imageName: "coffee"),
                menuObj.init(objId: 3, productName: "pork rice", daeName: "art.scnassets/porkRice/porkRice.dae",imageName: "porkRice"),
                menuObj.init(objId: 4, productName: "soap", daeName: "art.scnassets/soup/soup.dae",imageName: "soap")
                ])
            //"art.scnassets/coffee/coffee.dae"
        }
        return instance!
    }
    
    func setMenu(foodList : [menuObj])
    {
        menuArray = foodList
    }
    func getMenu() -> [menuObj]
    {
        return menuArray
    }
    func findFood(id : Int)->menuObj?
    {
        for obj in menuArray
        {
            if obj.objId == id
            {
                return obj
            }
        }
        return nil
    }
    
}
