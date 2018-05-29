//
//  ViewController.swift
//  VuforiaSample
//
//  Created by Yoshihiro Kato on 2016/07/02.
//  Copyright © 2016年 Yoshihiro Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var left: UIButton!
    
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var btn1: UIButton!

    
    let vuforiaLicenseKey = "AZxvRtj/////AAAAGf7uugt1bkiHlQnMeDAlkDkGSnXwQsc1sjgGKCcCgxgWkHsDmbYUJUIpezQUxqV68WS2g3Khn9BUJ6GX76GK/eQ0HiwCzjuNrqRIfKNQsXyUbMLsu+PM4E5cwpjWqo7rpIBS0mFtgigt3/UV9ppEM7VWK8V4/tZ/79MapprsSS3USd1279FVbyXfxpsqEFvmCJinQflZ5pQEycJukJtEC6VHSnqb7CvLzlRPjzmxR5Nr+48XDNwjSiaaeisMztBfD1bR0iPtVDy7QHqOug/ivMoeIkXTlcmnHClKSO8B/zzAr7rgO0FuoB+3opQtPW/LvrG28J9skDKmu0Pb5Bqs2BV1ZcL8MM+HOCRocjmb6sC6"
    

    
    let vuforiaDataSetFile = "aliveMathDemo.xml"
    
    
    var vuforiaManager: VuforiaManager? = nil
    
    @IBOutlet weak var sw: UISegmentedControl!
    var currentScene = sceneSetUp()
    let spaceNode = space()
    let mesh = meshGeometry(Resolution: 100, sideLength: 30)
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   
    
    
    let allVectors = Vector()
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    fileprivate var lastSceneName: String? = nil
    
    @IBAction func sceneSwitcher(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            self.currentScene.resetScene(id: 1 , scene: lastSceneName!)
            
            break
        case 1: self.currentScene.resetScene(id: 2 , scene: lastSceneName!)
            break
        default:
            break
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        
        SetUpRealm.setupRealm(){ (realm) -> Void in
            
            SetUpRealm.realm = realm
            print("done getting database")
        }
        
        left.setBackgroundImage(#imageLiteral(resourceName: "swipe left"), for:UIControlState.normal )
        right.setBackgroundImage(#imageLiteral(resourceName: "swipe right proofs "), for: UIControlState.normal)
        super.viewDidLoad()
        

        
        prepare()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        do {
            try vuforiaManager?.stop()
        }catch let error {
            print("\(error)")
        }
    }
}


private extension ViewController {
     func prepare() {
        vuforiaManager = VuforiaManager(licenseKey: vuforiaLicenseKey, dataSetFile: vuforiaDataSetFile)
        if let manager = vuforiaManager {
            manager.delegate = self
            manager.eaglView.sceneSource = self
            manager.eaglView.delegate = self
            manager.eaglView.setupRenderer()
            self.view = manager.eaglView
            
            self.view.addSubview(btn1)
            self.view.addSubview(left)
            self.view.addSubview(right)
            self.view.addSubview(sw)
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(didRecieveWillResignActiveNotification),
                                       name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(didRecieveDidBecomeActiveNotification),
                                       name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        vuforiaManager?.prepare(with: .portrait)
    }
    
    func pause() {
        do {
            try vuforiaManager?.pause()
        }catch let error {
            print("\(error)")
        }
    }
    
    func resume() {
        do {
            try vuforiaManager?.resume()
        }catch let error {
            print("\(error)")
        }
    }
}


extension ViewController {
    func didRecieveWillResignActiveNotification(_ notification: Notification) {
        pause()
    }
    
    func didRecieveDidBecomeActiveNotification(_ notification: Notification) {
        resume()
    }
}
extension ViewController: VuforiaManagerDelegate {
    func vuforiaManagerDidFinishPreparing(_ manager: VuforiaManager!) {
        print("did finish preparing\n")
        
        do {
            try vuforiaManager?.start()
            vuforiaManager?.setContinuousAutofocusEnabled(true)
        }catch let error {
            print("\(error)")
        }
    }
    
    func vuforiaManager(_ manager: VuforiaManager!, didFailToPreparingWithError error: Error!) {
        print("did faid to preparing \(error)\n")
    }
    
    func vuforiaManager(_ manager: VuforiaManager!, didUpdateWith state: VuforiaState!) {
        for index in 0 ..< state.numberOfTrackableResults {
            let result = state.trackableResult(at: index)
            let trackerableName = result?.trackable.name
            
            //print("\(String(describing: trackerableName))")
            if trackerableName == "image1"{
                
                if lastSceneName != "image1" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "image1"])
                    lastSceneName = "image1"
                    
                }
            }  else if trackerableName == "vectors"{
                
                if lastSceneName != "vectors" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "vectors"])
                    lastSceneName = "vectors"
                }
            }  else if trackerableName == "sin"{
                
                if lastSceneName != "sin" {
                    manager.eaglView.setNeedsChangeSceneWithUserInfo(["scene" : "sin"])
                    lastSceneName = "sin"
                }
            }
            
        }
    }
}

extension ViewController: VuforiaEAGLViewSceneSource, VuforiaEAGLViewDelegate , UIPopoverPresentationControllerDelegate , spaceProtocol , meshProtocol  , vectorsProtocol {
    
    
    func sendValuesFromVectorsToPreviousVC(vector1: SCNVector3, vector2: SCNVector3)
    {
        (self.currentScene.getCurrentNode() as! Vector).alterVectors(vector1: vector1, vector2: vector2)
        (self.currentScene.getCurrentNode() as! Vector).update()
        
    }
    
    func sendValuesFromSpaceToPreviousVC(r: Double, angle: Double, v: Double)
    {
        (self.currentScene.getCurrentNode() as! space).alterAngel(newAngel: angle)
        (self.currentScene.getCurrentNode() as! space).alterRadius(radius: r)
        (self.currentScene.getCurrentNode() as! space).alterVelocity(velocity: v)
        (self.currentScene.getCurrentNode() as! space).update()
    }
    
    
    func sendValuesFromMeshToPreviousVC(Data: [Double])
    {
        (self.currentScene.getCurrentNode() as! meshGeometry).equationType = Int(Data[0]) + 1
        
        if((self.currentScene.getCurrentNode() as! meshGeometry).equationType == 1)
        {
            
            (self.currentScene.getCurrentNode() as! meshGeometry).a = Data[1]
            (self.currentScene.getCurrentNode() as! meshGeometry).b = Data[2]
           // (self.currentScene.getCurrentNode() as! meshGeometry).c = Data[3]
            
        }
        
        (self.currentScene.getCurrentNode() as! meshGeometry).update()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "spacePop"
        {
            let popOverController = segue.destination as! spacePopOver
            popOverController.popoverPresentationController?.delegate = self
            let scene = self.currentScene.currentNode as! space
            
            popOverController.radius = scene.radius
            popOverController.angle =  scene.staticAngel
            popOverController.velocity = scene.velocity
            popOverController.delegate = self
            
        } else if segue.identifier == "meshPop"
        {
            let popOverController = segue.destination as! meshPopOver
            popOverController.popoverPresentationController?.delegate = self
            let scene = self.currentScene.currentNode as! meshGeometry
            self.currentScene.currentNode.name = "mesh"
            popOverController.a = scene.a
            popOverController.b = scene.b
            //popOverController.c = scene.c
            popOverController.delegate = self
        } else if segue.identifier == "vectorsPop"
        {
            let popOverController = segue.destination as! vectorsPopOver
            popOverController.popoverPresentationController?.delegate = self
            
            let scene = self.currentScene.currentNode as! Vector
            popOverController.vector1 = SCNVector3(scene.x1, scene.y1,scene.z1)
            popOverController.vector2 = SCNVector3(scene.x2, scene.y2, scene.z2)
            
            popOverController.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    
    
    func scene(for view: VuforiaEAGLView!, userInfo: [String : Any]?) -> SCNScene! {
        guard let userInfo = userInfo else {
            print("default scene")
            return createOrbitScene(with: view)
        }
        
        if let sceneName = userInfo["scene"] as? String , sceneName == "image1" {
            print("orbits scene")
            return createOrbitScene(with: view)
        }else if let sceneName = userInfo["scene"] as? String , sceneName == "vectors" {
            print("planes scene")
            
            return createVectorScene(with: view)
        }else if let sceneName = userInfo["scene"] as? String , sceneName == "sin" {
            print("trigonometry scene")
            return createMeshGeometry(with: view)
        }else {
            print("chips scene")
            return createOrbitScene(with: view)
        }
        
    }
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x:0, y:0, width:80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x:0.0,y: 0.0, width:40.0, height:40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func setView(uiView: UIView){
        self.view = uiView
    }
    func viewActivity(){
        showActivityIndicator(uiView: self.view)
    }
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    fileprivate func createMeshGeometry (with view: VuforiaEAGLView) ->SCNScene{
        
        self.refreshCurrentScene()
        self.currentScene.setCurrentNode(currentNode: mesh)
        
        return self.currentScene
    }
    
    fileprivate func createOrbitScene(with view: VuforiaEAGLView)->SCNScene {
        
        self.refreshCurrentScene()
        spaceNode.orbitRotation()
        self.currentScene.setCurrentNode(currentNode: spaceNode)
        return self.currentScene
    }
    
    
    fileprivate func createVectorScene(with view: VuforiaEAGLView) -> SCNScene {
        
        self.refreshCurrentScene()
        
        self.currentScene.setCurrentNode(currentNode: allVectors)
        return self.currentScene
    }
    
    func refreshCurrentScene(){
        self.currentScene = sceneSetUp()
    }
    
    
    func check(obj:Any)->String{
        if obj is space {
            return "space"
        }
        else if obj is meshGeometry {
            return "mesh"
        } else {
            return "vectors"
        }
    }
    
    func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        
        return false
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchDownNode node: SCNNode!) {
        print("touch down \(String(describing: node.name))\n")
        
        if(isObjectNotNil(object:self.currentScene.currentNode))
        {
            
            if(check(obj: self.currentScene.currentNode)=="space"){
                
                self.performSegue(withIdentifier: "spacePop" , sender: nil)
                
            }else if(check(obj: self.currentScene.currentNode)=="mesh"){
                
                self.performSegue(withIdentifier: "meshPop" , sender: nil)
                
            } else {
                
                self.performSegue(withIdentifier: "vectorsPop" , sender: nil)
            }
        }else {
            
        }
    }

    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchUp node: SCNNode!) {
        print("touch up \(String(describing: node.name))\n")
        
    }
    
    func vuforiaEAGLView(_ view: VuforiaEAGLView!, didTouchCancel node: SCNNode!) {
        print("touch cancel \(String(describing: node.name))\n")
        
    }
    
    
    
    
}


