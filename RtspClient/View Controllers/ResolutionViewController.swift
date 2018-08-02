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
    case 0:  HttpService.SOAPGet1  = "<?xml version=\"1.0\" encoding=\"utf-8\" ?                            ><configuration.ion><setparams>videoinput_1.h264_1.resolution="
        HttpService.SOAPGet2 = "4CIF"
        HttpService.SOAPGet3 = mainInstance.endstring
       
    case 1:  HttpService.SOAPGet1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
        HttpService.SOAPGet2 = "VGA"
        HttpService.SOAPGet3 = mainInstance.endstring
        
        
    case 2:  HttpService.SOAPGet1  = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
            HttpService.SOAPGet2  = "CIF"
            HttpService.SOAPGet3 = mainInstance.endstring
        
       
    case 3:  HttpService.SOAPGet1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
        HttpService.SOAPGet2  = "1280 x 720"
        HttpService.SOAPGet3 = mainInstance.endstring
        
    
        case 4: HttpService.SOAPGet1 = "<?xml version=\"1.0\"   encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution="
            HttpService.SOAPGet2  = "1920x1080"
            HttpService.SOAPGet3 = mainInstance.endstring
        
    
   
    default:
        break
        }
    }
    
    @IBOutlet weak var setButton: UIButton!
    @IBAction func setButtonOutlet(_ sender: Any) {
            let http = HttpService ()
                    http.postHttp()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                view.layer.borderColor = UIColor.white.cgColor
       
    }
    

 

}
