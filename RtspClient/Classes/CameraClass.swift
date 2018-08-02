//
//  CameraClass.swift
//  RtspClient
//
//  Created by Brian Hamilton on 8/1/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import Foundation

class Camera: NSObject {

    var mainLoad:String?
    var CameraModelNumber:String?
    var CameraInputFormat:String?
    var sourceFrameRate:String?
    var sensor:String?
    var h264List:String?
    var mjpegList:String?
    var attribute:String?
    var ipadd:String?

    func cameraInfo () {
    
        let text = mainLoad
        if text != nil {
        
                attribute  = (text?.sliceByString(from:"<attributes>" , to: "</attributes>") as Any as! String)
                h264List = (text?.sliceByString(from:"<component name=\"h264_1\">" , to: "</component>") as Any as! String)
//                mjpegList = (text?.sliceByString(from:"<component name=\"mjpeg_3\">" , to: "</component>") as Any as! String)
//                mjpegList = (text?.sliceByString(from:"<component name=\"mjpeg_1\">" , to: "</component>") as Any as! String)
                sensor = (text?.sliceByString(from: "<component name=\"sensor\">", to: "</component>") as Any as! String)
                CameraModelNumber  =  attribute?.sliceByString(from: "hdsensor\">", to: "</attribute>")!
                CameraInputFormat =  attribute?.sliceByString(from: "format\">" , to: "</attribute>")!
                sourceFrameRate = attribute?.sliceByString(from:  "sourceframerate\">", to: "</attribute>")!
                print(sourceFrameRate as Any)
                print(CameraModelNumber as Any)
         
            
            
    
    }
    
}
}
