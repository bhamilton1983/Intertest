//
//  ZoomParser.swift
//  RtspClient
//
//  Created by Brian Hamilton on 5/30/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//
import Foundation
import UIKit
class zoomParser: NSObject, XMLParserDelegate {
    
    var webData2 : NSMutableData?
    var webData1 : NSMutableData?
    var webData : NSMutableData?
    
    func getZoomCameraCommand () {
        
        let soapMessage1 = ZoomViewController.segmentChoice
        let soapMessage2 = ZoomViewController.currentZoomLevel
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        
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
class ExposureParser: NSObject, XMLParserDelegate {
    
    var webData2 : NSMutableData?
    var webData1 : NSMutableData?
    var webData : NSMutableData?
    
    func getSliderCommand () {
        
        let soapMessage1 = ExposureView.exposureControl
        let soapMessage2 = ExposureView.currentGainLevel    
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        
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
