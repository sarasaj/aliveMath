//
//  spacePopOver.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/22/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import Foundation
class spacePopOver : UIViewController {
    
    @IBOutlet weak var radiusFeild: UITextField!
    @IBOutlet weak var angleFeild: UITextField!
    @IBOutlet weak var velocityFeild: UITextField!
    
    
    
    var radius = Double() , velocity = Double() , angle = Double()
    
    @IBOutlet weak var okButton: UIButton!
    weak var delegate:spaceProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        radiusFeild.text = String(radius)
        velocityFeild.text = String(velocity)
        angleFeild.text = String(angle)
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
    }
    
    @IBAction func button(){
        self.delegate?.sendValuesFromSpaceToPreviousVC(r: (radiusFeild.text! as NSString).doubleValue , angle: (angleFeild.text! as NSString).doubleValue, v: (velocityFeild.text! as NSString).doubleValue)
        
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }
    
    
}

protocol spaceProtocol: class
{
    func sendValuesFromSpaceToPreviousVC(r:Double , angle: Double, v: Double)
}

