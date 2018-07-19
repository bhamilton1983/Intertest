//
//  UserSettingsClass.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/6/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
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
