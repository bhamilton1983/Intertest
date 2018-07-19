//
//  SoapXMLParser.swift
//  SoapDemoController
//
//  Created by Brian Hamilton on 4/25/18.
//  Copyright © 2018 Brian Hamilton. All rights reserved.
//

import Foundation
import UIKit
class SOAPXMLParser: NSObject, XMLParserDelegate {
   
        var webData2 : NSMutableData?
        var webData1 : NSMutableData?
        var webData : NSMutableData?
    
        func getZoomCommand () {
      
        let soapMessage1 = ExposureView.exposureControl
        let soapMessage2 = ExposureView.exposureControlSelected
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        
        print(soapMessage)
        print(soapMessage2)
        print(soapMessage)
 
        let url = NSURL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
     
        
        let theRequest = NSMutableURLRequest(url: url! as URL)
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        
        _ = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        
        }
    func connection(connection: NSURLConnection, didFailWithError error: NSError)
    
    {}
    
    func connection(connection: NSURLConnection, didReceiveResponse respose: URLResponse)
    
    {
        webData = NSMutableData()
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
        
    {
        
        webData!.append(data as Data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
    
    {
        let xmlStr = NSString(data: webData! as Data, encoding: String.Encoding.utf8.rawValue)
        
        print("xmlst\(String(describing: xmlStr))")
    
    
    }

}

class SOAPXMLParserBOOL: NSObject, XMLParserDelegate {
    
    var webData2 : NSMutableData?
    var webData1 : NSMutableData?
    var webData : NSMutableData?
    
    func getBoolCommand () {
        
        let soapMessage0 = mainInstance.firstString
        let soapMessage1 = ControlSideBar.control   
        let soapMessage2 = ControlSideBar.controlTF
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage0 + soapMessage1 + soapMessage2 + soapMessage3
        
        print(soapMessage)
        
    
        
        let url = NSURL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        
        
        let theRequest = NSMutableURLRequest(url: url! as URL)
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        
        _ = NSURLConnection(request: theRequest as URLRequest, delegate: self)
      print(soapMessage)
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError)
        
    {}
    
    func connection(connection: NSURLConnection, didReceiveResponse respose: URLResponse)
        
    {
        webData = NSMutableData()
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
        
    {
        
        webData!.append(data as Data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
        
    {
        let xmlStr = NSString(data: webData! as Data, encoding: String.Encoding.utf8.rawValue)
        
        print("xmlst\(String(describing: xmlStr))")
        
        
}
}
    class SOAPXMLParserPicker: NSObject, XMLParserDelegate {
        
        var webData2 : NSMutableData?
        var webData1 : NSMutableData?
        var webData : NSMutableData?
        
        func getParserCommand () {
            
            let soapMessage1 = mainInstance.shutterSpeed
            let soapMessage2 = PickerViewController.shutterPicked
            let soapMessage3 = mainInstance.endstring
            let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
            
            print(soapMessage)
            print(soapMessage2)
            print(soapMessage)
            
            let url = NSURL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
            
            
            let theRequest = NSMutableURLRequest(url: url! as URL)
            
            theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
            theRequest.httpMethod = "POST"
            theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
            
            _ = NSURLConnection(request: theRequest as URLRequest, delegate: self)
            
        }
        func connection(connection: NSURLConnection, didFailWithError error: NSError)
            
        {}
        
        func connection(connection: NSURLConnection, didReceiveResponse respose: URLResponse)
            
        {
            webData = NSMutableData()
            
        }
        
        func connection(connection: NSURLConnection, didReceiveData data: NSData)
            
        {
            
            webData!.append(data as Data)
        }
        
        func connectionDidFinishLoading(connection: NSURLConnection)
            
        {
            let xmlStr = NSString(data: webData! as Data, encoding: String.Encoding.utf8.rawValue)
            
            print("xmlst\(String(describing: xmlStr))")
            
            
        }
}

