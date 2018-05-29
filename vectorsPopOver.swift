//
//  vectorsPopOver.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/27/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation

class vectorsPopOver : UIViewController {
    
    @IBOutlet weak var vector1XFeild: UITextField!
    @IBOutlet weak var vector1YFeild: UITextField!
    @IBOutlet weak var vector1ZFeild: UITextField!
    
    
    
    @IBOutlet weak var vector2XFeild: UITextField!
    @IBOutlet weak var vector2YFeild: UITextField!
    @IBOutlet weak var vector2ZFeild: UITextField!
    
    
    var vector1 = SCNVector3() , vector2 = SCNVector3()
    
    @IBOutlet weak var okButton: UIButton!
    weak var delegate:vectorsProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        vector1XFeild.text = String(vector1.x)
        vector1YFeild.text = String(vector1.y)
        vector1ZFeild.text = String(vector1.z)
        
        vector2XFeild.text = String(vector2.x)
        vector2YFeild.text = String(vector2.y)
        vector2ZFeild.text = String(vector2.z)
        
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
    }
    
    @IBAction func button(){
        
        let vector1v2 = SCNVector3(x:(vector1XFeild.text! as NSString).floatValue , y: (vector1YFeild.text! as NSString).floatValue, z: (vector1ZFeild.text! as NSString).floatValue)
        
        let vector2v2 = SCNVector3(x:(vector2XFeild.text! as NSString).floatValue , y: (vector2YFeild.text! as NSString).floatValue, z: (vector2ZFeild.text! as NSString).floatValue)
        
        self.delegate?.sendValuesFromVectorsToPreviousVC(vector1: vector1v2, vector2:vector2v2)
        
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }
    
    
}

protocol vectorsProtocol: class
{
    func sendValuesFromVectorsToPreviousVC(vector1:SCNVector3 , vector2: SCNVector3)
}

