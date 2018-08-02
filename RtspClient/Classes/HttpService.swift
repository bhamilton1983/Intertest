//
//  HttpService.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/31/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import Foundation

class HttpService :NSObject, XMLParserDelegate,  URLSessionDelegate {
    
    var attributes:String?
    var sensor:String?
    var videoinput:String?
    static var camera = Camera()
    static var XMLPackage:String = ""
    static var SOAPGet1:String = ""
    static var SOAPGet2:String = ""
    static var SOAPGet3:String = ""
    var webData : NSMutableData?
    
    func getHttp() {
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
        let soapMessage1 = HttpService.SOAPGet1
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = HttpService.SOAPGet3
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        let session = URLSession.shared
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?sel=paramlist&params=videoinput_*.*,videoinput_*.*.*")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //            theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
        
                if parser.parse() {
          
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                                    HttpService.XMLPackage = html
                                    HttpService.camera.mainLoad = html
                                    HttpService.camera.cameraInfo()
                                    }
                        
                                    }
                                    }
                                    }
                                task.resume()
                                    }
    


func postHttp () {
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
    let soapMessage1 = HttpService.SOAPGet1
    let soapMessage2 = HttpService.SOAPGet2
    let soapMessage3 = HttpService.SOAPGet3
    let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
    let session = URLSession.shared
   
    let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
    var theRequest = URLRequest(url: url! as URL)
    theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
    theRequest.httpMethod = "POST"
    theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
    //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
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
    
 

        func getPickerValue () {
        
       
        let soapMessage1 = mainInstance.shutterSpeed
        let soapMessage2 = PickerViewController.shutterPicked
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
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
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
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
   
    

    func getExposure () {
    
    let soapMessage1 = ExposureView.exposureControl
    let soapMessage2 = ExposureView.exposureControlSelected
    let soapMessage3 = mainInstance.endstring
    let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
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
    //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
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

    func getBool() {

                let soapMessage0 = mainInstance.firstString
                let soapMessage1 = ControlSideBar.control
                let soapMessage2 = ControlSideBar.controlTF
                let soapMessage3 = mainInstance.endstring
                let soapMessage = soapMessage0 + soapMessage1 + soapMessage2 + soapMessage3
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
    //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
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

