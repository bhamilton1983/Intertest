

import UIKit

class BMNSDelegate : NSObject, NetServiceDelegate {
    func netServiceWillPublish(_ sender: NetService) {
        print("netServiceWillPublish:\(sender)");  //This method is called
    }
    
    
    func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]){
        print("didNotPublish:\(sender)");
    }
    
    func netServiceDidPublish(_ sender: NetService) {
        print("netServiceDidPublish:\(sender)");
    }
    func netServiceWillResolve(_ sender: NetService) {
        print("netServiceWillResolve:\(sender)");
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("netServiceDidNotResolve:\(sender)");
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        print("netServiceDidResolve:\(sender)");
    }
    
    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        print("netServiceDidUpdateTXTRecordData:\(sender)");
    }
    
    func netServiceDidStop(_ sender: NetService) {
        print("netServiceDidStopService:\(sender)");
    }
    
    func netService(_ sender: NetService,
                    didAcceptConnectionWith inputStream: InputStream,
                    outputStream stream: OutputStream) {
        print("netServiceDidAcceptConnection:\(sender)");
    }
}

class BMBrowserDelegate : NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    
    func netServiceBrowser(_ netServiceBrowser: NetServiceBrowser,
                           didFind netService: NetService,
                           moreComing moreServicesComing: Bool) {
        let nsnsdel = BMNSDelegate()
        netService.delegate = nsnsdel
        netService.resolve(withTimeout: 1)
        print(netService.domain) // local.
        print(netService.name) // This property is correct
        print(netService.type) // _http._tcp.
        print(netService.addresses) // Optional([])
        print(netService.hostName) // nil
        print(netService.port) // -1
        print(moreServicesComing) //false
    }
    
}


