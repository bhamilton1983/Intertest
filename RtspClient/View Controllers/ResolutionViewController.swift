//
//  ResolutionViewController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/25/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class ResolutionViewController: UIViewController {
   @IBOutlet weak var segmentResolutionController: UISegmentedControl!
    @IBAction func ResolutionAction(_ sender: Any) {
   
    switch segmentResolutionController.selectedSegmentIndex
    {
    case 0:  SOAPXMLParserVariable.soapString1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?                            ><configuration.ion><setparams>videoinput_1.h264_1.resolution="
        SOAPXMLParserVariable.soapString2 = "4CIF"
        SOAPXMLParserVariable.soapString3 = mainInstance.endstring
       
    case 1: SOAPXMLParserVariable.soapString1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
    SOAPXMLParserVariable.soapString2 = "VGA"
    SOAPXMLParserVariable.soapString3 = mainInstance.endstring
        
        
    case 2: SOAPXMLParserVariable.soapString1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
    SOAPXMLParserVariable.soapString2 = "CIF"
    SOAPXMLParserVariable.soapString3 = mainInstance.endstring
        
       
    case 3: SOAPXMLParserVariable.soapString1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
    SOAPXMLParserVariable.soapString2 = "1280 x 720"
    SOAPXMLParserVariable.soapString3 = mainInstance.endstring
        
    
    case 4:SOAPXMLParserVariable.soapString1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
    SOAPXMLParserVariable.soapString2 = "1920x1080"
    SOAPXMLParserVariable.soapString3 = mainInstance.endstring
        
    
   
    default:
        break
        }
    }
    
    @IBOutlet weak var setButton: UIButton!
    @IBAction func setButtonOutlet(_ sender: Any) {
        
        var xmlParser : SOAPXMLParserVariable?
            xmlParser = SOAPXMLParserVariable()
            xmlParser!.getParserCommand()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                view.layer.borderColor = UIColor.white.cgColor
       
    }
    

 

}
