//
//  menuObj.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/24.
//  Copyright © 2017年 JJing. All rights reserved.
//

import Foundation

class menuObj: NSObject {
    
    //ar assets - dae file name
    var arObjName : String = ""
    var objId : Int
    var productName : String
    var productImageName : String
    
    init(objId id:Int,productName name:String, daeName daename:String, imageName:String) {
        arObjName = daename
        objId = id
        productName = name
        productImageName = imageName
    }
    
}
