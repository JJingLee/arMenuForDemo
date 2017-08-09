//
//  ViewController.swift
//  threeDmodel
//
//  Created by Chieh-Chun Li on 2017/7/19.
//  Copyright © 2017年 JJing. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    //@IBOutlet var sceneView: ARSCNView!
    private var sceneView: ARSCNView = ARSCNView()
    
    //food node array.
    private var foodNodesArray : [SCNNode] = []
    
    //foodArea parameters.
    private var foodAreaWidth:Float = 0.8
    private var foodAreaheight:Float = 0
    private var foodAreaLength:Float = 0.8
    private var foodAreaX:Float = 0.0
    private var foodAreaY:Float = -0.2
    private var foodAreaZ:Float = -0.8
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSceneView()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //add notification
        configNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        //detect horizen
        //configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        //add area
        setFoodAreaPosition(x: 0.0, y: -0.2, z: -0.8)
        setFoodAreaFrame(width: 0.8, height: 0, length: 0.8)
        initialFoodArea()
    }
    
    //MARK: UI constraints
    private func initSceneView()
    {
        sceneView = ARSCNView();
        self.view.addSubview(sceneView)
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint.init(item: sceneView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint.init(item: sceneView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint.init(item: sceneView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint.init(item: sceneView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.view.addConstraints([width, height, centerX, centerY])
        
    }
    
    //MARK: ordering food mulnipulates
    func addFoodToCenterScreen(id : Int)
    {
        let foodObjNode = arFoodModels.shareInstance().getFoodObj(id: id)?.nodeOrdering
        guard let currentFrame = sceneView.session.currentFrame else
        {
            return;
        }
        //Set transform of node to be 10cm in front of camera.
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.5
        //print("arVC translation.column.w : \(translation.columns.3.w)")
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
        {
            translation.columns.0.z = 1
            translation.columns.1.z = 1
            translation.columns.2.z = 1
        }else
        {
            translation.columns.0.z = 5
            translation.columns.1.z = 0.1
            translation.columns.2.z = 0.1
        }
        
        
        foodObjNode!.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        //foodObjNode!.position = SCNVector3.init(x, y, z)
        if (id != 2)
        {
            foodObjNode!.scale = SCNVector3Make(0.0001, 0.0001, 0.0001)
        }
        else
        {
            foodObjNode!.scale = SCNVector3Make(0.01, 0.01, 0.01)
        }
        //foodObjNode!.scale = SCNVector3Make(0.0001, 0.0001, 0.0001)
        //foodNodesArray.append(foodObjNode!);
        sceneView.scene.rootNode.addChildNode(foodObjNode!)
        
    }
    
    func addFood(toPositionX x:Float, y:Float, z:Float, WithFoodId id:Int)
    {
        //                let foodObjInfo = menuModel.shareInstance().findFood(id: id)
        //                let billboardScene = SCNScene(named: "art.scnassets/chickenRice/chickenRice.dae")
        //        let foodObjNode = billboardScene?.rootNode.childNodes[0]
        
        let foodObjNode = arFoodModels.shareInstance().getFoodObj(id: id)?.nodeOrdering
        //foodObjNode!.position = SCNVector3.init(currentFrame.camera.transform.columns.0.x, y, currentFrame.camera.transform.columns.3.z-0.5)
        
        foodObjNode!.position = SCNVector3.init(x, y, z)
        foodObjNode!.scale = SCNVector3Make(0.0001, 0.0001, 0.0001)
        //foodNodesArray.append(foodObjNode!);
        sceneView.scene.rootNode.addChildNode(foodObjNode!)
        
    }
    
    
    private func addFoodRandonly(id : Int)
    {
        /*
         x : foodAreaX - foodAreaWidth/2 ~ fooAreaX + foodAreaWidth/2
         y : foodAreaY + foodAreaHeight/2
         z : foodAreaZ - foodAreaLength/2 ~ foodAreaZ + foodAreaLength/2
         */
        let randomX = (foodAreaX - foodAreaWidth/2) + ((Float)(arc4random_uniform(10)+1)/10) * foodAreaWidth
        let randomZ = (foodAreaZ - foodAreaLength/2) + ((Float)(arc4random_uniform(10)+1)/10)*foodAreaLength
        let Y = foodAreaY + foodAreaheight/2
        
        print("randomNum = \(randomX), \(Y), \(randomZ)")
        self.addFood(toPositionX: randomX, y: Y, z: randomZ, WithFoodId: id)
    }
    
    func removeFood(node : SCNNode)
    {
        node.removeFromParentNode()
        //        foodNodesArray.last?.removeFromParentNode()
        //        foodNodesArray.removeLast()
    }
    
    //MARK: foodArea configs
    private func initialFoodArea()
    {
        let foodArea = SCNBox(width: CGFloat(foodAreaWidth), height: CGFloat(foodAreaheight), length: CGFloat(foodAreaLength), chamferRadius: 0.5)
        foodArea.firstMaterial?.diffuse.contents = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        let foodAreaNode = SCNNode(geometry: foodArea)
        foodAreaNode.position = SCNVector3.init(foodAreaX, foodAreaY, foodAreaZ)
        sceneView.scene.rootNode.addChildNode(foodAreaNode)
    }
    private func setFoodAreaFrame(width:Float, height:Float, length:Float)
    {
        foodAreaWidth = width
        foodAreaheight = height
        foodAreaLength = length
    }
    private func setFoodAreaPosition(x:Float, y:Float, z:Float)
    {
        foodAreaX = x
        foodAreaY = y
        foodAreaZ = z
    }
    
    //MARK: notifications
    private func configNotification()
    {
        notificationsHandler.shareInstance().listenAddARFoodNotification(listenr: self, selector: #selector(self.addFoodNotificationhandler(notification:)))
        notificationsHandler.shareInstance().listenRemoveARFoodNotification(listenr: self, selector: #selector(self.removeFoodNotificationhandler(notification:)))
    }
    
    @objc private func addFoodNotificationhandler(notification : Notification)
    {
        let theId : Int = notification.object as! Int
        self.addFoodToCenterScreen(id: theId)
        print("add food \(theId)")
    }
    @objc private func removeFoodNotificationhandler(notification : Notification)
    {
        let theId : Int = notification.object as! Int
        //self.addFoodRandonly(id: theId)
        print("remove food \(theId)")
    }
    
    //MARK: view life cycle
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         x : foodAreaX - foodAreaWidth/2 ~ fooAreaX + foodAreaWidth/2
         y : foodAreaY + foodAreaHeight/2
         z : foodAreaZ - foodAreaLength/2 ~ foodAreaZ + foodAreaLength/2
         */
        //                let randomX = (foodAreaX - foodAreaWidth/2) + ((Float)(arc4random_uniform(10)+1)/10) * foodAreaWidth
        //                let randomZ = (foodAreaZ - foodAreaLength/2) + ((Float)(arc4random_uniform(10)+1)/10)*foodAreaLength
        //                let Y = foodAreaY + foodAreaheight/2
        //
        //                print("randomNum = \(randomX), \(Y), \(randomZ)")
        //                self.addFood(toPositionX: randomX, y: Y, z: randomZ,WithFoodId: 1)
        //
        
    }
    
    private func goBackLast()
    {
        notificationsHandler.shareInstance().rmAddARFoodNotification(listener: self)
        notificationsHandler.shareInstance().rmRemoveARFoodNotification(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}


