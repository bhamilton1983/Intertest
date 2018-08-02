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
    static var SOAPGlobal:String?
    func getZoomCameraCommand () {
        
        let soapMessage1 = ZoomViewController.segmentChoice
        let soapMessage2 = ZoomViewController.currentZoomLevel
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
            zoomParser.SOAPGlobal = soapMessage
        print(soapMessage)
        
        
        
        let credential = URLCredential(
            user: "admin",
            password: "admin",
            persistence: .forSession
        )
        let protectionSpace = URLProtectionSpace(
            host: "example.com",
            port: 80,
            protocol: "https",
            realm: nil,
            authenticationMethod: NSURLAuthenticationMethodHTTPBasic
        )
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
      
        let session = URLSession.shared

        let url = URL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }

        }
           task.resume()
    }
    
    func getSliderCommand () {
        
        let soapMessage1 = ExposureView.exposureControl
        let soapMessage2 = ExposureView.currentGainLevel    
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        zoomParser.SOAPGlobal = soapMessage
        let credential = URLCredential(
            user: "admin",
            password: "admin",
            persistence: .forSession
        )
        let protectionSpace = URLProtectionSpace(
            host: "example.com",
            port: 80,
            protocol: "https",
            realm: nil,
            authenticationMethod: NSURLAuthenticationMethodHTTPBasic
        )
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        
        let session = URLSession.shared
        let url = NSURL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
}

}

