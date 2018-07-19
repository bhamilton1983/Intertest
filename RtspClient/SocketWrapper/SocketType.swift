//
//  CommonSocketProtocols.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-04.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Darwin

/// Represents the base type for more specialized socket types.
protocol SocketType {

    /// The underlying `Socket` that is used for various methods of the sub types, e.g. `send()`, `receive()`. etc.
    var socket: Socket { get }

    /// Called whenever `close()` was called on the socket.
    /// This is an override point for implementers. The default implementation does nothing.
    func didClose()

}


// Common methods.
extension SocketType {

    /// Closes the socket and calls `didClose()`.
    func close() throws {
        defer {
            didClose()
        }
        try socket.close()
    }

    func didClose() {
        // Empty default implementation
    }

    /// Pass through to `Socket`'s `socketOption` subscript.
    subscript(option option: Int32) -> Int32 {
        get {
            return socket[socketOption: option]
        }
        nonmutating set {
            socket[socketOption: option] = newValue
        }
    }

}
