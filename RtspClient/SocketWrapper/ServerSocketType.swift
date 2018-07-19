//
//  ServerSocketProtocols.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-04.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Darwin
import Foundation

/// A server socket that can `bind()` to a port, and `listen()` and `accept()` connections from clients.
protocol ServerSocketType: AddressSocketType, AcceptAsyncSocketType {

}


// Convenience initializers.
extension ServerSocketType {

    /// Creates an instance for binding to the given port.
    ///
    /// - Parameter port: The port for the new server socket.
    ///
    /// - SeeAlso: `AddressInfoSequence.Storage`
    ///
    /// - TODO: Don't just pick the first address, but try the whole list for (the first?) one that works.
    ///   This may require a new initializer like `init(bindingToPort:)` that loops over the
    ///   `AddressInfoSequence` and calls `bind()` on each `addrinfo` until one works, then uses that
    ///   `addrinfo` to call `init(addrInfo:)`.
    init(port: String) throws {
        self = try AddressInfoSequence(forBindingToPort: port).withFirstAddrInfo { addrInfo in
            try Self.init(addrInfo: addrInfo)
        }
    }

}


// Basic server socket methods.
extension ServerSocketType {

    /// Binds the `socket` to the port specified by `address`.
    ///
    /// - Parameter reuseAddress: Whether to set `SO_REUSEADDR`, which is very 
    /// likely desired. See `getsockopt(2)` for details. Defaults to `true`.
    func bind(reuseAddress reuseAddress: Bool = true) throws {
        self[option: SO_REUSEADDR] = reuseAddress ? 1 : 0
        try address.withSockAddrPointer { sockAddr, length in
            try socket.bind(address: sockAddr, length: length)
        }
    }

    /// Listen for connections on a socket.
    ///
    /// - Parameter backlog: The maximum number of client connections that 
    /// are allowed to queue up for an `accept()` call. Defaults to `10`.
    func listen(backlog backlog: Int32 = 10) throws {
        try socket.listen(backlog: backlog)
    }

    /// Accepts a client connection and returns an instance of the client representation created by the given closure.
    ///
    /// - Parameter clientConnectedHandler: A closure that is called when a client connection is ready to be accepted.
    /// The closure is passed a `Socket` and `SocketAddress` and is expected to return an instance of a server-internal
    /// representation of a client connection that conforms to `ConnectedClientSocketType`. This instance is then
    /// returned to the caller of `accept()`.
    ///
    /// - Returns: The server-internal client representation created by `clientConnectedHandler`.
    func accept<T: ConnectedClientSocketType>(blocking blocking: Bool = false, @noescape clientConnectedHandler: (socket: Socket, address: SocketAddress) throws -> T) throws -> T {
        let (clientSocket, address) = try socket.accept(blocking: blocking)
        return try clientConnectedHandler(socket: clientSocket, address: address)
    }

    /// Accepts a client connection and returns an instance of a default client representation.
    ///
    /// - SeeAlso: `accept(blocking:, clientConnectedHandler:)`
    func accept(blocking blocking: Bool = false) throws -> ConnectedClientSocketType {
        return try accept(blocking: blocking) { socket, address in
            return ConnectedClientSocket(socket: socket, address: address)
        }
    }

}


/// A server socket that can accept asynchronously.
protocol AcceptAsyncSocketType: SocketType {

}

extension AcceptAsyncSocketType {

    /// Creates and returns a `SocketDispatchSource` that calls the given `readyToAcceptHandler`
    /// whenever data is available. One of the `accept()` methods can then be called without blocking.
    ///
    /// To stop accepting client connections asynchronously, call `cancel()` on the returned `SocketDispatchSource`.
    /// This also happens automatically in the `SocketDispatchSource.deinit`.
    ///
    /// - Returns: A `SocketDispatchSource` that must be held on to by the caller for as long as callbacks are to be received.
    func acceptAsync(queue queue: dispatch_queue_t = dispatch_get_global_queue(0, 0), readyToAcceptHandler: () -> Void) -> SocketDispatchSource {
        return SocketDispatchSource(socket: socket, queue: queue, eventHandler: readyToAcceptHandler)
    }

}

/// A minimal implementation of the `ServerSocketType`.
struct ServerSocket: ServerSocketType {
    
    let socket: Socket
    let address: SocketAddress
    
}
