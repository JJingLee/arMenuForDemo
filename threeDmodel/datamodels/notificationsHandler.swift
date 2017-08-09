//
//  notificationsHandler.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/25.
//  Copyright © 2017年 JJing. All rights reserved.
//

import Foundation

class notificationsHandler:NSObject{
    
    static var instance : notificationsHandler?
    static func shareInstance()->notificationsHandler
    {
        if instance==nil
        {
            instance = notificationsHandler()
        }
        return instance!
    }
    
    //MARK: add AR food
    func postAddARFoodNotification(id : Int)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addARFoodNotification"), object: id)
    }
    func listenAddARFoodNotification(listenr : Any, selector : Selector)
    {
        NotificationCenter.default.addObserver(listenr, selector: selector, name: NSNotification.Name(rawValue: "addARFoodNotification"), object: nil)
    }
    func rmAddARFoodNotification(listener : Any)
    {
        NotificationCenter.default.removeObserver(listener, name: NSNotification.Name(rawValue: "addARFoodNotification"), object: nil)
    }
    
    //MARK: remove AR food
    func postRemoveARFoodNotification(id : Int)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeARFoodNotification"), object: id)
    }
    func listenRemoveARFoodNotification(listenr : Any, selector : Selector)
    {
        NotificationCenter.default.addObserver(listenr, selector: selector, name: NSNotification.Name(rawValue: "removeARFoodNotification"), object: nil)
    }
    func rmRemoveARFoodNotification(listener : Any)
    {
        NotificationCenter.default.removeObserver(listener, name: NSNotification.Name(rawValue: "removeARFoodNotification"), object: nil)
    }
    
    
}
