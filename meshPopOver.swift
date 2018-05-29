//
//  meshPopOver.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/17/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import UIKit

class meshPopOver: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    var a = Double() , b = Double()
    //c = Double()
    var ALabel = UILabel() , BLabel = UILabel(), CLabel = UILabel()
    var AtF = UITextField() ,  BtF = UITextField()
    //CtF = UITextField()
    var pickerDataSource = ["A * cos(b * x +C)+A * sin(b * y +C)", "abs( cos(x) * sin(y))", "y^2/16 - x^2/25","sin(φ + √x^2 + y^2)"]
    
    
    //  var container: UIView = UIView()
    // var loadingView: UIView = UIView()
    //var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    
    var dataPicker = [Double]()
    
    var choosenEquation = Int()
    weak var delegate:meshProtocol?
    
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var equations: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        AtF = UITextField(frame: CGRect(x: 20, y: 150, width: 90, height: 30))
        BtF = UITextField(frame: CGRect(x: 120, y: 150, width: 90, height: 30))
        //CtF = UITextField(frame: CGRect(x: 160, y: 150, width: 70, height: 30))
        
        AtF.backgroundColor = UIColor.white
        BtF.backgroundColor = UIColor.white
        //CtF.backgroundColor = UIColor.white
        
        AtF.borderStyle = .roundedRect
        BtF.borderStyle = .roundedRect
       // CtF.borderStyle = .roundedRect
        
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.2)
        self.equations.dataSource = self
        self.equations.delegate = self
        equations.selectedRow(inComponent: 0)
        switcher(row: 0)
        
        
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 8)
        
        // where data is an Array of String
        label.text = pickerDataSource[row]
        
        return label
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func switcher(row : Int)
    {
        if(row == 0)
        {
            self.choosenEquation = 0
            
            AtF.placeholder = "amplitude = \(self.a)"
            BtF.placeholder = "wave length = \(self.b)"
           // CtF.placeholder = "C = \(self.c)"
            
            
            self.view.addSubview(AtF)
            self.view.addSubview(BtF)
            //self.view.addSubview(CtF)
            
        }
        else if(row == 1)
        {
            AtF.removeFromSuperview()
            BtF.removeFromSuperview()
            //CtF.removeFromSuperview()
            self.choosenEquation = 1
            
        }
        else if(row == 2)
        {
            AtF.removeFromSuperview()
            BtF.removeFromSuperview()
           // CtF.removeFromSuperview()
            self.choosenEquation = 2
            
        }else if (row == 3){
            AtF.removeFromSuperview()
            BtF.removeFromSuperview()
            //CtF.removeFromSuperview()
            self.choosenEquation = 3
        }
    }
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    /*  func showActivityIndicator(uiView: UIView) {
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
     
     *//*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    /*func hideActivityIndicator(uiView: UIView) {
     activityIndicator.stopAnimating()
     container.removeFromSuperview()
     }
     */
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    
    //// In order to show the activity indicator, call the function from your view controller
    //// ViewControllerUtils().showActivityIndicator(self.view)
    //// In order to hide the activity indicator, call the function from your view controller
    //// ViewControllerUtils().hideActivityIndicator(self.view)
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switcher(row: row)
        
    }
    
    @IBAction func button(){
        
        // meshPopOver().showActivityIndicator(uiView: self.view)
        activityIndicator.startAnimating()
        self.dataPicker.append(Double(self.choosenEquation))
        
        
        if(self.choosenEquation == 0) {
            
            self.dataPicker.append((self.AtF.text! as NSString).doubleValue)
            self.dataPicker.append((self.BtF.text! as NSString).doubleValue)
            //self.dataPicker.append((self.CtF.text! as NSString).doubleValue)
            
        }else {
            self.dataPicker.append(Double(self.choosenEquation))
        }
        self.delegate?.sendValuesFromMeshToPreviousVC(Data: dataPicker)
        
        let tmpController :UIViewController! = self.presentingViewController
        
        self.dismiss(animated: false, completion: {()->Void in
            print("done");
            tmpController.dismiss(animated: false, completion: nil);
        });
    }
    
}

protocol meshProtocol: class
{
    func sendValuesFromMeshToPreviousVC(Data:[Double])
}
