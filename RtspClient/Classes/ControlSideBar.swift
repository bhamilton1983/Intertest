//
//  ControlSideBar.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/6/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class ControlSideBar: UIViewController {
    static var autofocusState:String = ""
 
    static var control:String = ""
    static var controlTF:String = ""
    @IBOutlet weak var autoFocus: UISegmentedControl!
    @IBOutlet weak var autoExposure: UISegmentedControl!
    
    @IBAction func autofocusChange(_ sender: Any) {
        switch  autoFocus.selectedSegmentIndex
       
        {
        case 0:
        
            autofocusOn()
        
        case 1:
            
            autofocusOff()
        
        default:
            break
        }
       
    }
    
    @IBOutlet weak var autoExposureChange: UISegmentedControl!
    
    @IBAction func autoExposureChanged(_ sender: Any) {
   
    switch  autoExposure.selectedSegmentIndex
    
    {
    case 0:
    
    autoExposureOn()
    
    case 1:
    
    autoExposureOff()
    
    default:
    break
    }
    
}
func autofocusOn ()
{
    ControlSideBar.controlTF = "true"
    ControlSideBar.control  = boolCommands.autoFocus
    var xmlParser : SOAPXMLParserBOOL?
    xmlParser = SOAPXMLParserBOOL()
    xmlParser!.getBoolCommand()
    
}
func autoExposureOn()
{
    ControlSideBar.control  = automaticExposure.autoExposure
    ControlSideBar.controlTF = "auto"
    var xmlParser : SOAPXMLParserBOOL?
    xmlParser = SOAPXMLParserBOOL()
    xmlParser!.getBoolCommand()
    
}

    func autoExposureOff ()
    {
        ControlSideBar.controlTF = "manual"
        ControlSideBar.control  = automaticExposure.autoExposure
        var xmlParser : SOAPXMLParserBOOL?
        xmlParser = SOAPXMLParserBOOL()
        xmlParser!.getBoolCommand()
        
    }
func autofocusOff()
{
    ControlSideBar.control  = boolCommands.autoFocus
    ControlSideBar.controlTF = "false"
    var xmlParser : SOAPXMLParserBOOL?
    xmlParser = SOAPXMLParserBOOL()
    xmlParser!.getBoolCommand()
   
    }

    @IBOutlet weak var controlSegmentInput: UISegmentedControl!
    
    
 




            override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



}
