//
//  AddressSocketType.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-11.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Darwin

/// A `SocketType` that has a `SocketAddress` associated with it.
protocol AddressSocketType: SocketType {

    /// The address that the `socket` is associated with.
    /// - In a client, this is the address of the server the client socket `connect()`ed to.
    /// - In a client, this is the address of the local port the server socket `bind()`ed to.
    var address: SocketAddress { get }

    /// Creates an instance with the given `socket` and `address`.
    init(socket: Socket, address: SocketAddress) throws

}

// Initializers.
extension AddressSocketType {

    /// Creates an instance with a given `addrinfo`.
    init(addrInfo: addrinfo) throws {
        let socket = try Socket(addrInfo: addrInfo)
        let address = SocketAddress(addrInfo: addrInfo)
        try self.init(socket: socket, address: address)
    }

}


// Common computed properties.
extension AddressSocketType {

    /// Returns the connected client's `host` and `port` by querying its `address.nameInfo()`.
    func nameInfo() throws -> (host: String, port: String) {
        return try address.nameInfo()
    }

    /// - For a server socket, returns `nil`.
    /// - For a client socket, returns the hostname the socket is connected to.
    var host: String? {
        return try? address.nameInfo().host
    }

    /// - For a server socket, returns the port the socket is `bind()`ed to.
    /// - For a client socket, returns the port the socket is `connect()`ed to.
    var port: String? {
        return try? address.nameInfo().port
    }

}
