//
//  ControllerClass.swift
//  RtspClient
//
//  Created by Brian Hamilton on 5/29/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit



class ControllerClass: UIViewController {
    
 
      
    @IBOutlet weak var tranSwitch: UISwitch!
    
    @IBOutlet var ControllerClassView: UIView!
    
    @IBOutlet weak var tranView: UIView!
    
   
    static var buttonTapped:String = ""
    static var opacityLevel:Float = 0.0
    static var opacityLevel2:Float = 0.0
    static var cornerRadius:Float = 0.0
    static var borderSize:Float = 0.0
    static var vFX: Int = 0
    static var vFY: Int = 0
    static var current: Float = 0.0
     static var DEGREES_TO_RADIANS: Float = 0.0

    static var vFX1: Int = 0
    static var vFY1: Int = 0
    static var sizeX1: Float = 1920.0
    static var sizeY1: Float = 1080.0
    static var sizeX2: Float = 320.0
    static var sizeY2: Float = 256.0
    
    @IBOutlet weak var sliderYSize2: UISlider!
    @IBOutlet weak var sliderXSize2: UISlider!
    @IBOutlet weak var sliderYSize1: UISlider!
    @IBOutlet weak var sliderXSize1: UISlider!
    @IBOutlet weak var size1XLabel: UILabel!
    @IBOutlet weak var size1YLabel: UILabel!
    @IBOutlet weak var sizeXLabel: UILabel!
    @IBOutlet weak var sizeYLabel: UILabel!
    @IBOutlet weak var spot1X: UILabel!
    @IBOutlet weak var SpotY1: UILabel!

    @IBOutlet weak var slider6: UILabel!
    @IBOutlet weak var slider4: UILabel!
    @IBOutlet weak var borderSlider: UISlider!
    @IBOutlet weak var buttonNumber1: UIButton!
    @IBOutlet weak var slider5: UILabel!
    @IBAction func button1(_ sender: UIButton) {
            
     
            
            
            ControllerClass.buttonTapped = mirrorInstance.both
            
            var xmlParser : SOAPXMLParser?
            
            xmlParser = SOAPXMLParser()
            
            xmlParser!.getZoomCommand()
            
            
        }
    @IBOutlet weak var sliderChange5: UISlider!
    @IBOutlet weak var sliderChange6: UISlider!
    
    @IBOutlet weak var slider3: UILabel!
    @IBOutlet weak var cornerRadiusChanged: UISlider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderValueChange: UISlider!
    @IBAction func sliderAction(_ sender: UISlider) {
        ControllerClass.opacityLevel = Float(sender.value)
        label.text = "\(ControllerClass.opacityLevel)"
     
    }
    @IBOutlet weak var slider2: UILabel!
    
    @IBOutlet weak var sliderValue2: UISlider!
    
    @IBAction func sliderChange2(_ sender:UISlider) {
        ControllerClass.opacityLevel2 = Float(sender.value)
       slider2.text = "\(ControllerClass.opacityLevel2)"
        
    }
    @IBAction func radiusChanged(_ sender: UISlider) {
        ControllerClass.cornerRadius = Float(sender.value)
        slider3.text = "\(ControllerClass.cornerRadius)"
    }
    @IBAction func borderChanged(_ sender: UISlider) {
        ControllerClass.borderSize = Float(sender.value)
        slider4.text = "\(ControllerClass.borderSize)"
    }
    @IBAction func sliderValueChangeX(_ sender: UISlider) { ControllerClass.vFX = Int(sender.value)
        slider6.text = "\(ControllerClass.vFX)"
    }
    
    @IBAction func sliderValueChangeY(_ sender: UISlider) {
        ControllerClass.vFY = Int(sender.value)
        slider5.text = "\(ControllerClass.vFY)"
    }
    

    
    @IBAction func layer2moveX(_ sender: UISlider) {
        ControllerClass.vFY1 = Int(sender.value)
       SpotY1.text = "\(ControllerClass.vFY1)"
        
    }
    
    
    @IBAction func layer2MoveY(_ sender: UISlider) {
        ControllerClass.vFX1 = Int(sender.value)
        spot1X.text = "\(ControllerClass.vFX1)"
    }
    
    
    
    
    
    @IBAction func buttonNone(_ sender: Any) {
        
        ControllerClass.buttonTapped = mirrorInstance.none
        
        var xmlParser : SOAPXMLParser?
        
        xmlParser = SOAPXMLParser()
        
        xmlParser!.getZoomCommand()
        
    }
    
    @IBAction func icrFlip(_ sender: Any) {
        ControllerClass.buttonTapped = mirrorInstance.mirror
        
        var xmlParser : SOAPXMLParser?
        
        xmlParser = SOAPXMLParser()
        
        xmlParser!.getZoomCommand()
        
    }
   
    @IBAction func sliderChangeSizeX(_ sender: UISlider) {
        ControllerClass.sizeX1 = sender.value
        sizeXLabel.text = "\(ControllerClass.sizeX1)"
        ControllerClass.sizeY1 = Float(sender.value) * (9/16)
        
        
    }
    
    
    @IBAction func sliderChangeSizeXTwo(_ sender: UISlider) {
        ControllerClass.sizeX2 = sender.value
        size1XLabel.text = "\(ControllerClass.sizeX2)"
        ControllerClass.sizeY2 = Float(Int(sender.value) * (4/3))
    }

    
    @IBAction func transSwitch(_ sender: Any) {
        if tranSwitch.isOn == true {
            transHideControl()
        }
        if tranSwitch.isOn == false {
            transShowControl()
        }
    }
    
    
    func transHideControl(){
        tranView.isHidden = true
    }
    func transShowControl(){
        tranView.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
