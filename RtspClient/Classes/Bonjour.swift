


extension NSData {
    func castToCPointer<T>() -> T {
        let mem = UnsafeMutablePointer<T>.alloc(sizeof(T.Type))
        self.getBytes(mem, length: sizeof(T.Type))
        return mem.move()
    }
}

@objc enum BrowserOperation: Int {
    case SearchStopped
    case DidNotSearched
    case NotResolved
}

@objc protocol BrowserDelegate {
    func browser(browser: Browser, didFailedAt operation: BrowserOperation, withErrorDict errorDict: [String: NSNumber]?)
    func browser(browser: Browser, didFindService service: NSNetService, atHosts host: [String])
    func browser(browser: Browser, didRemovedService service: NSNetService)
    
    optional func browserDidStart(browser: Browser)
    optional func browserDidStopped(browser: Browser)
    optional func browser(browser: Browser, serviceDidUpdateTXT service: NSNetService, TXT txt: NSData)
}

class Browser: NSObject, NSNetServiceBrowserDelegate, NSNetServiceDelegate {
    private let svr = NSNetServiceBrowser()
    
    private var type = ""
    private var proto = ""
    private var domain = ""
    
    weak var delegate: BrowserDelegate?
    
    var services = Set<NSNetService>()
    
    init(type: String, proto: String, domain: String = "") {
        super.init()
        
        self.type = type
        self.proto = proto
        self.domain = domain
        svr.delegate = self
    }
    
    func start() {
        svr.searchForServicesOfType("_\(type)._\(proto)", inDomain: domain)
        svr.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func stop() {
        svr.stop()
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didRemoveService service: NSNetService, moreComing: Bool) {
        self.services.remove(service)
    }
    func netServiceBrowserWillSearch(browser: NSNetServiceBrowser) {
        delegate?.browserDidStart?(self)
    }
    
    func netServiceBrowserDidStopSearch(browser: NSNetServiceBrowser) {
        delegate?.browserDidStopped?(self)
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        delegate?.browser(self, didFailedAt: .DidNotSearched, withErrorDict: errorDict)
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didFindService service: NSNetService, moreComing: Bool) {
        service.delegate = self
        service.resolveWithTimeout(0.0)
        service.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        services.insert(service)
    }
    
    func netServiceDidResolveAddress(sender: NSNetService) {
        var ips = [String]()
        if let addresses = sender.addresses where addresses.count > 0 {
            for address in addresses {
                let ptr: sockaddr_in = address.castToCPointer()
                
                ips += [String(CString: inet_ntoa(ptr.sin_addr), encoding: NSASCIIStringEncoding)!]
                
            }
        }
        
        delegate?.browser(self, didFindService: sender, atHosts: ips)
    }
    
    func netService(sender: NSNetService, didNotResolve errorDict: [String : NSNumber]) {
        delegate?.browser(self, didFailedAt: .NotResolved, withErrorDict: errorDict)
    }
    
    func netService(sender: NSNetService, didUpdateTXTRecordData data: NSData) {
        delegate?.browser?(self, serviceDidUpdateTXT: sender, TXT: data)
    }
}

class Example: NSObject, BrowserDelegate {
    let browser = Browser(type: "fs20", proto: "tcp")
    
    override init() {
        super.init()
        
        browser.delegate = self
        browser.start()
    }
    
    func browser(browser: Browser, didFailedAt operation: BrowserOperation, withErrorDict errorDict: [String : NSNumber]?) {
        print("Failed \(operation) \(errorDict)")
    }
    
    func browser(browser: Browser, didFindService service: NSNetService, atHosts host: [String]) {
        let txt = NSString(data: service.TXTRecordData()!, encoding: NSASCIIStringEncoding)
        print("Find service: \(service.name) \(service.port) \(host.first!) \(txt)")
    }
    
    func browser(browser: Browser, didRemovedService service: NSNetService) {
        print("Service removed")
    }
}

let b = Example()

