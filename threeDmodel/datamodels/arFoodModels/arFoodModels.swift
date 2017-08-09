//
//  arFoodModels.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/24.
//  Copyright © 2017年 JJing. All rights reserved.
//

import Foundation
import SceneKit

class arFoodModels: NSObject {
    private static var instance : arFoodModels?
    private var arOnPlaneFoods : [arFoodObj] = []
    private let notificationHandler = notificationsHandler.shareInstance()
    
    static func shareInstance() -> arFoodModels {
        if instance == nil
        {
            instance = arFoodModels()
        }
        return instance!
    }
    
    func addFoodToArray(id:Int, node:SCNNode)
    {
        let newFoodObj = arFoodObj.init(objId: id, node: node)
        arOnPlaneFoods.append(newFoodObj)
        notificationHandler.postAddARFoodNotification(id: id)
    }
    
    func removeFoodFromArray(id:Int)
    {
        var index = 0
        for foodObj in arOnPlaneFoods
        {
            if foodObj.objId == id
            {
                foodObj.nodeOrdering?.removeFromParentNode()
                arOnPlaneFoods.remove(at: index)
                notificationHandler.postRemoveARFoodNotification(id: id)
                break
            }
            index += 1
        }
    }
    
    func getFoodObj(id : Int)->arFoodObj?
    {
        var index = 0
        for foodObj in arOnPlaneFoods
        {
            if foodObj.objId == id
            {
                return foodObj
            }
            index += 1
        }
        return nil
    }
    
}
