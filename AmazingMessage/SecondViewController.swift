//
//  SecondViewController.swift
//  AmazingMessage
//
//  Created by 孙港 on 2017/9/19.
//  Copyright © 2017年 孙港. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SecondViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /*// Set the view's delegate
         sceneView.delegate = self
         
         //Don't show statistics such as fps and timing information
         sceneView.showsStatistics = false
         
         // Create a new scene
         let scene = SCNScene(named: "art.scnassets/ship.scn")!
         
         // Set the scene to the view
         sceneView.scene = scene*/
        
        
        //生成带文字图片
        let letter:String = "hello world"
        // 取第一个字符(测试了,太长了的话,效果并不好)
        //let letter = (text as NSString).substring(to: 1)
        let sise = CGSize(width: 400, height: 50)
        let rect = CGRect(origin: CGPoint.zero, size: sise)
        // 开启上下文
        UIGraphicsBeginImageContext(sise)
        // 拿到上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        // 取较小的边
        //let minSide = min(400.0, 50.0)
        // 设置填充颜色
        ctx?.setFillColor(UIColor(displayP3Red: 59/255.0, green: 151/255.0, blue: 247/255.0, alpha: 0.75).cgColor)
        // 填充绘制
        ctx?.fill(rect)
        let attr = [ NSAttributedStringKey.foregroundColor : UIColor(displayP3Red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 50)]
        // 写入文字
        (letter as NSString).draw(at: CGPoint(x: 50, y: 0), withAttributes: attr)
        // 得到图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        
        
        // 存放所有 3D 几何体的容器
        let scene = SCNScene()
        // 想要绘制的 3D 立方体
        let boxGeometry = SCNBox(width: 16, height: 2, length: 0, chamferRadius: 0)
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3Make(0, 0, -30)
        //boxNode.rotation = SCNVector4Make(0.1,0.1,0.1,.pi)
        let material = SCNMaterial()
        material.diffuse.contents = image//UIImage(named: "text1")
        let white = SCNMaterial()
        white.diffuse.contents = UIImage(named: "white")
        //let white = UIImage(named: "white")
        boxNode.geometry?.materials  = [material, white, white, white, white, white]
        boxNode.opacity = 1
        //boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        //scene.rootNode.addChildNode(boxNode)
        
        let planeGeometry = SCNPlane(width: 16,height: 2)
        planeGeometry.cornerRadius = 0.2
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(0, 0, -30)
        planeNode.geometry?.materials = [material]
        scene.rootNode.addChildNode(planeNode)
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
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

