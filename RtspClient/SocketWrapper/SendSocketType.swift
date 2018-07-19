//
//  SendSocketType.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-11.
//  Copyright © 2016 Objective Development. All rights reserved.
//

/// A `SocketType` that can `receive()`.
protocol SendSocketType: SocketType {

    /// Called before `send()` was called on the socket.
    /// This is an override point for implementers. The default implementation does nothing.
    func willSend(bytes: UnsafeBufferPointer<Socket.Byte>)

    /// Called after `send()` was called on the socket.
    /// This is an override point for implementers. The default implementation does nothing.
    func didSend(bytes: UnsafeBufferPointer<Socket.Byte>)

}

// Basic sending functionality.
extension SendSocketType {

    /// Sends the bytes in the given `buffer`. May call `Socket.send()` repeatedly until all bytes have been sent.
    func send(buffer: UnsafeBufferPointer<Socket.Byte>) throws {
        let bytesToSend = buffer.count
        var bytesSent = 0

        willSend(buffer)
        while bytesSent < bytesToSend {
            bytesSent += try socket.send(buffer.baseAddress + bytesSent, count: bytesToSend - bytesSent)
        }
        didSend(buffer)
    }

    func willSend(bytes: UnsafeBufferPointer<Socket.Byte>) {
        // Empty default implementation
    }

    func didSend(bytes: UnsafeBufferPointer<Socket.Byte>) {
        // Empty default implementation
    }

}


// Extended functionality that builds upon the basic `send()` method.
extension SendSocketType {

    /// Convenience method to send an `Array<Socket.Byte>`.
    func send(bytes: [Socket.Byte]) throws {
        try bytes.withUnsafeBufferPointer { try send($0) }
    }

    /// Convenience method to send an arbitrary `CollectionType` of `Socket.Byte`s.
    func send<T: CollectionType where T.Generator.Element == Socket.Byte>(bytes: T) throws {
        try send(Array(bytes))
    }

    /// Convenience method to send a `String`.
    ///
    /// - Parameter includeNulTerminator: Whether to send a `NUL` terminator (defaults to `false`).
    func send(message: String, includeNulTerminator: Bool = false) throws {
        try message.withUTF8UnsafeBufferPointer(includeNulTerminator: includeNulTerminator) { try send($0) }
    }
    
}
