//
//  arFoodObj.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/24.
//  Copyright © 2017年 JJing. All rights reserved.
//

import Foundation
import SceneKit

class arFoodObj: NSObject {
    //uuid
    var objId : Int = 0
    
    //3d node
    var nodeOrdering : SCNNode?
    
    //count
    var countOfFood : Int = 0
    
    init(objId id : Int, node:SCNNode) {
        objId = id
        nodeOrdering = node
        countOfFood = 1
    }
    
    func addCount() {
        countOfFood += 1
    }
    func minusCount(){
        countOfFood -= 1
        if countOfFood <= 0
        {
            countOfFood = 0
        }
    }
    
}
