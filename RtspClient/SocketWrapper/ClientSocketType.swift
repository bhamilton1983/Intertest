//
//  ClientSocketProtocols.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-04.
//  Copyright © 2016 Objective Development. All rights reserved.
//

/// Represents a client socket that can `connect()` to a peer identified by a `host` and `port`.
protocol ClientSocketType: AddressSocketType, SendReceiveSocketType {

}

extension ClientSocketType {

    /// Creates an instance by resolving the given `host` and `port`.
    ///
    /// - Parameter host: The hostname or IP address to resolve.
    /// - Parameter port: The port or service name to resolve, e.g. "80" or "http".
    ///
    /// - SeeAlso: `AddressInfoSequence.Storage`
    ///
    /// - TODO: Don't just pick the first address, but try the whole list for (the first?) one that works.
    ///   This may require a new initializer like `init(connectingToHost:port:)` that loops over the 
    ///   `AddressInfoSequence` and calls `connect()` on each `addrinfo` until one works, then uses that 
    ///   `addrinfo` to call `init(addrInfo:)`.
    init(host: String, port: String) throws {
        self = try AddressInfoSequence(forConnectingToHost: host, port: port).withFirstAddrInfo { addrInfo in
            try Self.init(addrInfo: addrInfo)
        }
    }

    /// Connects to `address`.
    func connect() throws {
        // Note: It would be nice if this method returned a new `ConnectedClientSocketType` that does not allow
        // calling `connect()` a second time. `ClientSocketType` could then be a subtype of `AddressSocketType`
        // only (without `SendReceiveSocketType`), meaning that you'd first have to create a `ClientSocketType`
        // and call `connect()` on it to get back a new `ConnectedClientSocketType` which would then be the only
        // one to be able to `send()` and `receive()`. This would also have the nice effect that a socket couldn't
        // `send()` or `receive()` before being `connect()`ed.
        //
        // There are some issues with that approach, though:
        //  - A mechanism similar to `ServerSocketType.accept()` would be necessary to allow callers to decide
        //    which concrete adopter of `ConnectedClientSocketType` should be used. This is a bit cumbersome for 
        //    something that isn't strictly necessary here.
        //  - `self` and the newly created socket would share the same underlying file descriptor, making it
        //    unclear for the callsite to decide which one should `close()` the socket.

        try address.withSockAddrPointer { sockAddr, length in
            try socket.connect(address: sockAddr, length: length)
        }
    }
    
}

/// A minimal implementation of the `ClientSocketType`.
struct ClientSocket: ClientSocketType {

    let socket: Socket
    let address: SocketAddress

}
