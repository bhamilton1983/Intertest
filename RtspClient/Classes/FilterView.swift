//
//  FilterView.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/6/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class FilterView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
        static var filterPicked:String = "CISepiaTone"
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
            FilterView.filterPicked = pickerData[row] as String
            pickerLabel.text = FilterView.filterPicked
        }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return myTitle
    }
    
    
    @IBOutlet weak var pickerLabel: UILabel!
    static var pickerLabelText:String = ""
    
        @IBOutlet weak var picker: UIPickerView!
        var pickerData: [String] = [String]()
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            self.picker.delegate = self
            self.picker.dataSource = self
            pickerData = [
                "CIPhotoEffectChrome",
                "CIPhotoEffectFade",
                "CIPhotoEffectInstant",
                "CIPhotoEffectNoir",
                "CIPhotoEffectProcess",
                "CIPhotoEffectTonal",
                "CIPhotoEffectTransfer",
                "CISepiaTone",
                "CIColorClamp",
                "CIDiscBlur",
                "CIMotionBlur",
                "CIColorPosterize",
                "CIMaskToAlpha",
                "CIGlassDistortion",
                "CICMYKHalftone",
                "CISharpenLuminance",
                "CIBumpDistortion",
                
                
            ]
          
        }
        
        @IBOutlet weak var filterSet: UIButton!
        @IBAction func filterButton(_ sender: Any) {
            
            PhotoController.filterName = pickerLabel.text!
            print(PhotoController.filterName)
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
