//
//  LoginTable.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/27/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.
//

import UIKit

class LoginTable: UIViewController, UITableViewDataSource,UITableViewDelegate,NetServiceBrowserDelegate, NetServiceDelegate {

    
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var nsb : NetServiceBrowser!
    var services = [NetService]()
    var ipaddress1:String?
    var ipaddress2:String = ""
    var data: [String] = []
    var newArray: [String] = []
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
        return newArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        let text = newArray[indexPath.row]
        cell.textLabel?.text = text //3.
       
        let cellButton = UIButton()
        cellButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        cellButton.setTitle(text, for: UIControl.State.normal)
        cellButton.backgroundColor = UIColor.gray
        cell.addSubview(cellButton)
        cellButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        return cell //4.
    }
    
 @objc func buttonClicked(sender: UIButton!) {
    
    print("doesthiswork")
    
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
                print("service \(service.name) of type \(service.type)," +
                    "port \(service.port), addresses \(service.addresses!))")
                print(service.addresses!)
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
        newArray.append(ipaddress1!)
        print(newArray)
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
}

