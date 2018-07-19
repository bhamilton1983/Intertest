    //
//  SideBar1.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/8/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class SideBar1: UIViewController {
    static var control:String = ""
    static var controlSecond:String = ""
    @IBOutlet weak var autoExposure: UISegmentedControl!
    
    @IBOutlet weak var autofocus: UISegmentedControl!
    
    @IBOutlet weak var flipICR: UISegmentedControl!
    
    
    @IBAction func autoExposureChange(_ sender: Any) {
        switch autoExposure.selectedSegmentIndex
        {
        case 0:
            
                autoExposureOn()
        case 1:
                autoExposureOff()
        default:
            break
            
        }
        
        
    }
    
    
    @IBAction func autoFocusChange(_ sender: Any) {
        switch autofocus.selectedSegmentIndex
        {
        case 0:
            autofocusOn()
        case 1:
            autofocusOff()
        default:
            break
    }
    }
    
    
    @IBAction func flipICRChange(_ sender: Any) {
        
        switch flipICR.selectedSegmentIndex
        {
        case 0:
            flipICRon()
        case 1:
                flipICROff()
        default:
            break
        }
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    
    func autofocusOn ()
    {
        SideBar1.controlSecond = "true"
        SideBar1.control  = "autofocus="
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
        
    }
    func autoExposureOn()
    {
        SideBar1.control  = "automaticexposure"
        SideBar1.controlSecond = "auto"
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
        
    }
    
    func autoExposureOff ()
    {
        SideBar1.controlSecond = "manual"
        SideBar1.control  = "automaticexposure"
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
        
    }
    func autofocusOff()
    {
        SideBar1.control  = "autofocus="
        SideBar1.controlSecond = "false"
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
        
    }
    
    func flipICRon ()
    {
        SideBar1.controlSecond = "true"
        SideBar1.control  = "icr="
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
        
    }
    func flipICROff ()
    {
        SideBar1.control  = "icr="
        SideBar1.controlSecond = "false"
        var xmlParser : StreamTwoParserBool?
        xmlParser = StreamTwoParserBool()
        xmlParser!.getBoolCommandStream2()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


