//
//  Login.swift
//  RtspClient
//
//  Created by Brian Hamilton on 6/7/18.
//
//

import UIKit
import Foundation

class Login: UIViewController,UIScrollViewDelegate, UIGestureRecognizerDelegate, NetServiceDelegate {
    
    var IOnodesServiceVariable = NetService()
    @IBOutlet var loginScreenMainView: UIView!
    @IBOutlet weak var loginScroll: UIScrollView!
    @IBOutlet weak var findBoardButton: UIButton!
    var streamToggle1 = 1
    var identity = CGAffineTransform.identity


    @IBOutlet weak var userText: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var ipaddress: UITextField!
    
    @IBOutlet weak var compButton: UIButton!
    @IBOutlet weak var inputSelector: UISegmentedControl!
    static var username:String = ""
    static var password:String = ""
    static var ip:String = ""
    static var video:String = ""
    static var media:String = ""
    static var rtsp:String = ""
    static var controller:String = ""
    func textFieldShouldReturn(ipaddress: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    @IBAction func inputSegemetSelector(_ sender: Any) {
        switch inputSelector.selectedSegmentIndex
        {
        case 0:
            Login.video = "videoinput_1"
        case 1:
            Login.video = "videoinput_2"
        default:
            break
    }
    
    }
 

    @IBAction func setCompButton1Tapped(_ sender: Any) {
        
        if streamToggle1 == 1 {
            Login.media = "h264_1"
         compButton.setTitle("H.264", for: UIControl.State.normal)
            streamToggle1 = 2
        } else {
            if streamToggle1 == 2 {
                Login.media = "mjpeg_1"
               compButton.setTitle("MJPEG", for: UIControl.State.normal)
                
                streamToggle1 = 1
             }
    
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scale))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        //
        gestureRecognizer.delegate = self
        pinchGesture.delegate = self
        rotationGesture.delegate = self
        //
        loginScroll.minimumZoomScale = 0.5
        loginScroll.maximumZoomScale = 10.0
        loginScroll.zoomScale = 1.0
        loginScroll.layer.cornerRadius = 10
        loginScroll.layer.borderWidth = 1
        loginScroll.layer.borderColor = UIColor.white.cgColor
        loginScroll.addGestureRecognizer(rotationGesture)
        loginScroll.addGestureRecognizer(gestureRecognizer)
        loginScroll.addGestureRecognizer(pinchGesture)
   
    }
    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: loginScroll)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: loginScroll)
        }
    }
    @objc func scale(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            identity = loginScroll.transform
        case .changed,.ended:
            loginScroll.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        case .cancelled:
            break
        default:
            break
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return loginScroll
    }
    @objc func rotate(_ gesture: UIRotationGestureRecognizer) {
        loginScroll.transform = loginScroll.transform.rotated(by: gesture.rotation)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @IBAction func setButtonTapped(_ sender: Any) {
        Login.username = userText.text!
        Login.password = passWord.text!
        Login.ip = ipaddress.text!
      //  Login.video = videoinput.text!
       // Login.media = stream.text!
        Login.rtsp =  "rtsp://\(Login.username):\(Login.password)@\(Login.ip)/\(Login.video)/\(Login.media)/media.stm"
        
        print(Login.rtsp)
    }
    @IBAction func findButton(_ sender: Any) {
      
        startSearch()
  
    }
    struct addrinfo {
    
        
        var first = UnsafeMutablePointer<Any>.self
        var second = UnsafeMutablePointer<Any>.self
        
        var third =  UnsafePointer<addrinfo>?.self
        
        var fourth =  UnsafeMutablePointer<UnsafeMutablePointer<addrinfo>?>?.self
    }
    
    func startSearch() {
     


       
        }
    
    
    func sockaddrDescription(addr: UnsafePointer<sockaddr>) -> (String?, String?) {
        
        var host : String?
        var service : String?
        
        var hostBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        var serviceBuffer = [CChar](repeating: 0, count: Int(NI_MAXSERV))
        
        if getnameinfo(
            addr,
            socklen_t(addr.pointee.sa_len),
            &hostBuffer,
            socklen_t(hostBuffer.count),
            &serviceBuffer,
            socklen_t(serviceBuffer.count),
            NI_NUMERICHOST | NI_NUMERICSERV)
            
            == 0 {
            
            host = String(cString: hostBuffer)
            service = String(cString: serviceBuffer)
        }
        return (host, service)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension ifaddrs {
    /// Returns the IP address.
    var ipAddress: String? {
        var buffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        let address = ifa_addr.pointee
        let result = getnameinfo(ifa_addr, socklen_t(address.sa_len), &buffer, socklen_t(buffer.count), nil, socklen_t(0), NI_NUMERICHOST)
        return result == 0 ? String(cString: buffer) : nil
    }
}


