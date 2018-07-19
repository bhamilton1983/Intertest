//
//  ZoomViewController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 5/30/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
   


    static  var segmentChoice = String()
    static  var currentZoomLevel = String()
    
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var zoomSliderLevel: UISlider!

 
    
    @IBAction func ZoomSlider(_ sender: UISlider) {
        
        let zoomLevel = Int(sender.value)
        zoomLabel.text = "\(zoomLevel)"
        var xmlParser : zoomParser?
        xmlParser = zoomParser()
        xmlParser!.getZoomCameraCommand()
        ZoomViewController.currentZoomLevel = String(zoomLevel)
    }
    
    @IBOutlet weak var sliderPicker: UISegmentedControl!
    @IBAction func segementedButton(_ sender: Any) {
        switch sliderPicker.selectedSegmentIndex
        {
        case 0:
            ZoomViewController.segmentChoice = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentzoomlevel="
        case 1:
            ZoomViewController.segmentChoice = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentfocuslevel="
        case 2:
            ZoomViewController.segmentChoice = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentirislevel="
        default:
        break
         }
    }
    

    
    
    
    
    
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
