//
//  ExposureView.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/2/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class ExposureView: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var gainLevelSlider: UISlider!
    static var exposureControlSelected:String = ""
    static var exposureControl:String = ""
    static var currentGainLevel = String ()
    static var currentIrisLevel = String ()
    static var currentMotorLevel = String ()
    @IBOutlet weak var irisLabelExpoView: UILabel!
    
    @IBOutlet weak var irisSliderExpo: UISlider!
    @IBOutlet weak var whiteBalanceSegment: UISegmentedControl!
    @IBOutlet weak var autoExposureSegment: UISegmentedControl!
    @IBOutlet weak var manualICRSegment: UISegmentedControl!
    
    @IBOutlet weak var motorSlider: UISlider!
    @IBOutlet weak var motorLabel: UILabel!
    @IBOutlet weak var wdrSegment: UISegmentedControl!
    
    
    
    
    @IBAction func motionSlider(_ sender: UISlider) {
        
        ExposureView.exposureControl = sliderSensCommand.gainLevel
        let gainLevel = Int(sender.value)
        gainLabel.text = "\(gainLevel)"
        var xmlParser : ExposureParser?
        xmlParser = ExposureParser()
        xmlParser!.getSliderCommand()
        ExposureView.currentGainLevel = String(gainLevel)
        
    }
    
    
    
    
    @IBAction func AutoExposureAction(_ sender: Any) {
        
        switch  autoExposureSegment.selectedSegmentIndex
            
        {
        case 0:
            autoExposureOn()
        case 1:
            
            autoExposureOff()
            
        default:
            break
        }

    }
    
    @IBAction func flipICR(_ sender: Any) {
        switch  manualICRSegment.selectedSegmentIndex
            
        {
        case 0:
            
            ICROn()
            
        case 1:
            ICROff()
       
            
        default:
            break
        }
        
    }
    
    
    @IBAction func wdrSegmentAction(_ sender: Any) {
        switch wdrSegment.selectedSegmentIndex
        
        {
        case 0:
            wdrOn()
        case 1:
            wdrOff()
        default:
            break
      
        }
        
    }
    
    @IBAction func whiteBalanceAction(_ sender: Any) {
        
        switch whiteBalanceSegment.selectedSegmentIndex
        {
        case 0:
            whiteBalanceAuto()
        case 1:
            whiteBalanceIndoor()
        case 2:
            whiteBalanceOutdoor()
        case 3:
            whiteBalanceSodium()
            
        default:
            break
        }
    }

    @IBOutlet weak var gainLabel: UILabel!
    
    @IBAction func gainSlider(_ sender: UISlider) {
        
         ExposureView.exposureControl = sliderSensCommand.gainLevel
        let gainLevel = Int(sender.value)
        gainLabel.text = "\(gainLevel)"
        var xmlParser : ExposureParser?
        xmlParser = ExposureParser()
        xmlParser!.getSliderCommand()
        ExposureView.currentGainLevel = String(gainLevel)
        
        
        
    }
    
    @IBAction func irisSliderChangeExpo(_ sender: UISlider) {
   
        ExposureView.exposureControl = mainInstance.iris
        let irisLevel = Int(sender.value)
        irisLabelExpoView.text = "\(irisLevel)"
        var xmlParser : ExposureParser?
        xmlParser = ExposureParser()
        xmlParser!.getSliderCommand()
        ExposureView.currentIrisLevel = String(irisLevel)
    
    
    
    }
    
    
    
    
    static var shutterPicked:String = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // Catpure the picker view selection
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PickerViewController.shutterPicked = pickerData[row] as String
        pickerLabel.text = PickerViewController.shutterPicked
    }
    
    @IBOutlet weak var pickerLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["\(shutterInstance.oneTenThousandth)", "\(shutterInstance.oneSixThousandth)","\(shutterInstance.oneFourThousandth)", "\(shutterInstance.oneThreeThousandth)","\(shutterInstance.oneTwoThousandth)","\"\(shutterInstance.oneFifteenHundreth)","\(shutterInstance.oneThousandth)","\(shutterInstance.oneSevenTwentyFive)","\(shutterInstance.oneFiveHundred)","\(shutterInstance.oneThreeFifty)","\(shutterInstance.oneTwoFifty)","\(shutterInstance.oneOneEighty)","\(shutterInstance.oneOneEighty)","\(shutterInstance.oneOneHundred)","\(shutterInstance.oneNinety)","\(shutterInstance.oneSixty)", "\(shutterInstance.oneThirty)", "\(shutterInstance.oneFour)", "\(shutterInstance.oneOne)"]
        
    }
    
    @IBOutlet weak var shutterSet: UIButton!
    @IBAction func setShutterButton(_ sender: Any) {
        
        var xmlParser :SOAPXMLParserPicker?
        xmlParser = SOAPXMLParserPicker()
        xmlParser!.getParserCommand()
        
    }
        // Do any additional setup after loading the view.
    }
    func autoExposureOff ()
    {
        ControlSideBar.controlTF = "manual"
        ControlSideBar.control  = automaticExposure.autoExposure
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

    func wdrOn()
{
   
  
    ControlSideBar.control = "widedynamicrange"
    ControlSideBar.controlTF = "=true"
    var xmlParser : SOAPXMLParserBOOL?
    xmlParser = SOAPXMLParserBOOL()
    xmlParser!.getBoolCommand()
}
func wdrOff()
{
    
    ControlSideBar.control = "widedynamicrange"
    ControlSideBar.controlTF = "=false"
    var xmlParser : SOAPXMLParserBOOL?
    xmlParser = SOAPXMLParserBOOL()
    xmlParser!.getBoolCommand()
}
func whiteBalanceAuto ()

{
    ExposureView.exposureControl = whitebalanceInstance.front
    ExposureView.exposureControlSelected  = "auto"
    var xmlParser : SOAPXMLParser?
    xmlParser = SOAPXMLParser()
    xmlParser!.getZoomCommand()
    
}
func whiteBalanceIndoor ()
    
{
    ExposureView.exposureControl = whitebalanceInstance.front
    ExposureView.exposureControlSelected  = "indoor"
    var xmlParser : SOAPXMLParser?
    xmlParser = SOAPXMLParser()
    xmlParser!.getZoomCommand()
    
}
func whiteBalanceOutdoor()
    
{
    ExposureView.exposureControl = whitebalanceInstance.front
    ExposureView.exposureControlSelected  = "outdoor"
    var xmlParser : SOAPXMLParser?
    xmlParser = SOAPXMLParser()
    xmlParser!.getZoomCommand()
    
}
func whiteBalanceSodium()
    
{
    ExposureView.exposureControl = whitebalanceInstance.front
    ExposureView.exposureControlSelected  = "sodium"
    var xmlParser : SOAPXMLParser?
    xmlParser = SOAPXMLParser()
    xmlParser!.getZoomCommand()
    
}
func ICROn()
    
{
    ExposureView.exposureControl = icrCommands.firstICR
    ExposureView.exposureControlSelected  = "true"
    var xmlParser : SOAPXMLParser?
    xmlParser = SOAPXMLParser()
    xmlParser!.getZoomCommand()
    
}
func ICROff()
    
    {
        ExposureView.exposureControl = icrCommands.firstICR
        ExposureView.exposureControlSelected  = "false"
        var xmlParser : SOAPXMLParser?
        xmlParser = SOAPXMLParser()
        xmlParser!.getZoomCommand()
        
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


