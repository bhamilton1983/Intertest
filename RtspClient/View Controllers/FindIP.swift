

import UIKit



class LoginIP: UIViewController, NetServiceBrowserDelegate, NetServiceDelegate {
    var nsb : NetServiceBrowser!
    var services = [NetService]()
    var newArray: [String] = []
    var ipaddress1:String = ""
    var ipaddress2:String = ""
    @IBOutlet weak var ip2Label: UILabel!
    @IBOutlet weak var ipFind: UIButton!
    @IBAction func doButton (_ sender: Any!) {
        print("listening for services...")
        self.services.removeAll()
        self.nsb = NetServiceBrowser()
        self.nsb.delegate = self
        self.nsb.searchForServices(ofType:"_ionodes-media._tcp", inDomain: "local")
        var servicesFound:Int
        servicesFound = services.count
        
        
        
       
            if servicesFound == 0 {
            ipLabel.text = "no devices found"
                ip2Label.text = "check that devices are on network"
            
            }
           
            else
            {
            ipaddress1 = ipLabel.text!
            ipaddress2 = ip2Label.text!
            
        }
    }
    
    
    @IBOutlet weak var ipLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    
    
    @IBOutlet weak var secondButton: UIButton!
    
  @IBAction func setIP(_ sender: Any) {
    Login.rtsp = "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov"
    Login.ip = "\(ipaddress1)"
        performSegue(withIdentifier: "cameraShow", sender: Any?.self)
   }
   @IBAction func setIP2(_ sender: Any) {
       Login.rtsp = "rtsp://admin:admin@\(ipaddress2)/videoinput_1/h264_1/media.stm"
        Login.ip = "\(ipaddress2)"
        performSegue(withIdentifier: "cameraShow", sender: Any?.self)
   }

    func updateInterface () {
        for service in self.services {
            if service.port == -1 {
                print("service \(service.name) of type \(service.type)" +
                    " not yet resolved")
                service.delegate = self
                service.resolve(withTimeout:20)
            } else {
                print("service \(service.name) of type \(service.type)," +
                    "port \(service.port), addresses \(service.addresses!))")
                print(service.addresses!)
//                ipLabel.text = self.newArray[0]
//                ip2Label.text = self.newArray[1]
            }
        }
    }

    func netServiceDidResolveAddress(_ sender: NetService) {
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        guard let data = sender.addresses?.first else { return }
        data.withUnsafeBytes { (pointer:UnsafePointer<sockaddr>) -> Void in
            guard getnameinfo(pointer, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else {
                return
            }
        }
      
        let ipAddress = String(cString:hostname)
        newArray.append(ipAddress)
        self.updateInterface()
        print(newArray)
    }

  
    func netServiceBrowser(_ aNetServiceBrowser: NetServiceBrowser, didFind aNetService: NetService, moreComing: Bool) {
        print("adding a service")
        self.services.append(aNetService)
        if !moreComing {
            self.updateInterface()
        }
    }
    
    func netServiceBrowser(_ aNetServiceBrowser: NetServiceBrowser, didRemove aNetService: NetService, moreComing: Bool) {
        if let ix = self.services.index(of:aNetService) {
            self.services.remove(at:ix)
            print("removing a service")
            if !moreComing {
                self.updateInterface()
            }
        }
    }
}
