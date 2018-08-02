//
//  LoginTable.swift
//  RtspClient
//  Created by Brian Hamilton on 7/27/18.


import UIKit

class LoginTable: UIViewController, UITableViewDataSource,UITableViewDelegate,NetServiceBrowserDelegate, NetServiceDelegate, URLSessionDelegate {

    var mutableData : NSMutableData = NSMutableData()
    var camera = Camera()
    var cameraArray = [Camera]()
    var mainDict = [String:[Camera]]()
    static var servicePort:Int?
    static var hostname:String?
    @IBOutlet weak var tableView: UITableView!
    var nsb : NetServiceBrowser!
    var services = [NetService]()
    var ipaddress1:String?
    static var ipaddress2:String?
    var data: [String] = []
    static var newArray: [String] = []
    
    
    
    
    
    @IBAction func doButton (_ sender: Any!) {
        print("listening for services...")
        self.services.removeAll()
        self.nsb = NetServiceBrowser()
        self.nsb.delegate = self
        self.nsb.searchForServices(ofType:"_ionodes-media._tcp", inDomain: "local")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LoginTable.newArray.count
    }
    
    static var textCell:String?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell")! //1.
        cell.backgroundColor = UIColor.clear
        let text = LoginTable.newArray[indexPath.row]
        cell.textLabel?.text = text //3.
        let modelNumber = UILabel()
        modelNumber.tag = indexPath.row
        let track_Button = UIButton()
        track_Button.setTitle("Set", for: .normal)
        let btnImage = UIImage(named: "play_active_48")
        track_Button.setImage (btnImage, for: UIControl.State.normal)
        track_Button.frame = CGRect(x: self.view.frame.size.width - 50, y: 0, width: 40, height: 40)
        track_Button.backgroundColor = UIColor.clear
        track_Button.addTarget(self, action: #selector(track_Button_Pressed(sender:)), for: UIControl.Event.touchDown)
        track_Button.tag = indexPath.row
        modelNumber.text = camera.CameraModelNumber
        cell.addSubview(track_Button)
        return cell //4.
    }
    
        @objc func track_Button_Pressed(sender: UIButton!) {
        
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
                let index = self.tableView.indexPathForRow(at: buttonPosition)!
                let position = index.row
                Login.ip = LoginTable.newArray[position]
                Login.rtsp = "rtsp://admin:admin@\(LoginTable.newArray[position])/videoinput_1/h264_1/media.stm"
                let http = HttpService()
                http.getHttp()
                camera.cameraInfo()
                self.tableView.reloadData()
            
              performSegue(withIdentifier: "showCamera", sender: UIButton.self)
                
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
    }
    
    func updateInterface () {
        for service in self.services {
            if service.port == -1 {
                print("service \(service.name) of type \(service.type)" +
                    " not yet resolved")
                service.delegate = self
                service.resolve(withTimeout:20)
            } else {
//                print("service \(service.name) of type \(service.type)," +
//                    "port \(service.port), addresses \(service.addresses!))")
//                print(service.addresses!)
              
                LoginTable.servicePort = service.port
                LoginTable.hostname = service.name
                self.tableView.reloadData()
               
             
                
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
        ipaddress1 = String(cString:hostname)
        LoginTable.newArray.append(ipaddress1!)
        cameraArray.append(camera)
        mainDict.updateValue(cameraArray, forKey: ipaddress1!)
        self.updateInterface()
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
    func loadCameraArray() {
        
        for _ in mainDict {
            
        _ = camera.ipadd
        
            }

    print("main",mainDict)
        print("add",camera.ipadd as Any)
        print(cameraArray)
        }
}
