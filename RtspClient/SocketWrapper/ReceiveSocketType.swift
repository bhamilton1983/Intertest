//
//  ReceiveSocketType.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-11.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Foundation

/// A `SocketType` that can `receive()`.
protocol ReceiveSocketType: SocketType {

    /// Called right before `receive()` will be called on the socket.
    /// This is an override point for implementers. The default implementation does nothing.
    func willReceive()

    /// Called after `receive()` was called on the socket.
    /// This is an override point for implementers. The default implementation does nothing.
    func didReceive(buffer: UnsafeMutableBufferPointer<Socket.Byte>, bytesReceived: Int)

}


// Basic functionality.
extension ReceiveSocketType {

    /// Receives data until `Socket.receive()` returns because no more data is available, or because `buffer` is full.
    ///
    /// - SeeAlso: `Socket.receive(_, flags:, blocking:)`
    func receive(buffer: UnsafeMutableBufferPointer<Socket.Byte>, blocking: Bool = false) throws -> Int {
        willReceive()
        let result = try socket.receive(buffer, blocking: blocking)
        didReceive(buffer, bytesReceived: result)
        return result
    }

    func willReceive() {
        // Empty default implementation
    }

    func didReceive(buffer: UnsafeMutableBufferPointer<Socket.Byte>, bytesReceived: Int) {
        // Empty default implementation
    }

}


/// An answer that various `receive()` methods' handler callback can return.
enum ReceiveSocketMessageHandlerResponse {

    /// Continue receiving after the handler callback returns.
    case ContinueReceiving

    /// Stop receiving after the handler callback returns.
    case StopReceiving
}


// Extended functionality that builds upon the basic `receive()` method.
extension ReceiveSocketType {

    /// Receives `maxBytes` or or less.
    ///
    /// - Note: This method may be slow because it allocates an `UnsafeBufferPointer`,
    /// writes into it and then converts the received bytes into an `Array`.
    ///
    /// - Returns: An `Array` of `Socket.Byte`s whose count is the number of
    /// actual bytes received, not `maxBytes`.
    ///
    /// - SeeAlso: `receive(_:, blocking:)`
    func receive(maxBytes maxBytes: Int = 1024, blocking: Bool = false) throws -> [Socket.Byte] {
        let pointer = UnsafeMutablePointer<Socket.Byte>.alloc(maxBytes)
        let buffer = UnsafeMutableBufferPointer(start: pointer, count: maxBytes)
        let bytesReceived = try receive(buffer, blocking: blocking)
        let result = Array(buffer[0..<bytesReceived])
        pointer.destroy(maxBytes)
        pointer.dealloc(maxBytes)
        return result
    }

    /// Receives a UTF-8 string that is at most `maxBytes` long. A `NUL` terminator is not required to be sent by the peer.
    ///
    /// - Returns: The `String` received or `nil` if the data is not valid UTF8.
    ///
    /// - SeeAlso: `receive(maxBytes:, blocking:)`
    func receiveUTF8String(maxBytes maxBytes: Int = 1024, blocking: Bool = false) throws -> String? {
        let buffer = try receive(maxBytes: maxBytes, blocking: blocking)
        let string = String(UTF8CodeUnits: buffer)
        return string
    }

    /// Receives an arbitrary amount of bytes that are terminated by a given `terminator`.
    ///
    /// This method allocates an internal `Array<Socket.Byte>` that it appends data to as it receives it. 
    /// After a call to `receive(_, blocking:)` returns, the received data is searched for the `terminator`
    /// sequence of bytes and if it was found, the given `messageHandler` is called with that data.
    ///
    /// - Parameter terminator: A `CollectionType` whose `Element`s are `Socket.Byte`s.
    /// - Parameter messageHandler: A callback closure that is called whenever the `terminator` sequence of bytes
    /// was found in the received data. The callback's return value determines whether to continue receiving or not.
    ///
    /// - SeeAlso: `receive(_:, blocking:)`
    func receive<T: CollectionType where T.Generator.Element == Socket.Byte, T.Index == Int>(terminator terminator: T, blocking: Bool = false, @noescape messageHandler: ArraySlice<Socket.Byte> throws -> ReceiveSocketMessageHandlerResponse) throws {
        let terminatorCount = terminator.count
        var receivedBytes = Array<Socket.Byte>()
        var terminatorEndIndex = 0

        let bufferCount = 1024
        let pointer = UnsafeMutablePointer<Socket.Byte>.alloc(bufferCount)
        let buffer = UnsafeMutableBufferPointer(start: pointer, count: bufferCount)
        // pointer.initializeFrom([Socket.Byte](count: bufferCount, repeatedValue: 0))

        receiveLoop: while true {
            let bytesReceived = try receive(buffer, blocking: blocking)

            let firstSearchRangeStartIndex = max(0, receivedBytes.count - terminatorCount)
            receivedBytes.appendContentsOf(buffer[0..<bytesReceived])
            let lastSearchRangeStartIndex = max(0, receivedBytes.count - terminatorCount)

            for i in firstSearchRangeStartIndex...lastSearchRangeStartIndex {
                if receivedBytes.suffixFrom(i).startsWith(terminator) {
                    terminatorEndIndex = i + terminatorCount - 1
                    let message = receivedBytes[0...terminatorEndIndex]

                    switch try messageHandler(message) {
                    case .ContinueReceiving:
                        receivedBytes.removeFirst(terminatorEndIndex + 1)
                        continue receiveLoop

                    case .StopReceiving:
                        break receiveLoop
                    }
                }
            }
        }

        // pointer.destroy(bufferCount)
        pointer.dealloc(bufferCount)
    }

    /// Receives a UTF-8 string of arbitrary length that is terminated by the `terminator` string.
    ///
    /// - Parameter terminator: A string that represents the end of a message.
    /// - Parameter appendNulToTerminator: If `true`, a `NUL`-terminated `terminator` String is expected to be sent by the peer.
    ///
    /// - SeeAlso: `receive(terminator:, blocking:, messageHandler:)`
    func receiveUTF8String(terminator terminator: String = "\n", appendNulToTerminator: Bool = false, blocking: Bool = false, @noescape messageHandler: String throws -> ReceiveSocketMessageHandlerResponse) throws {
        return try terminator.withUTF8UnsafeBufferPointer(includeNulTerminator: false) { terminatorBuffer in
            try receive(terminator: terminatorBuffer, blocking: blocking) { messageBytes in
                let message: String = try messageBytes.withUnsafeBufferPointer { buffer in
                    guard let message = NSString(bytes: buffer.baseAddress, length: buffer.count, encoding: NSUTF8StringEncoding) else {
                        throw Socket.Error.ReceivedInvalidData
                    }
                    return message as String
                }
                return try messageHandler(message)
            }
        }
    }

}

/// A socket that can receive asynchronously.
protocol ReceiveAsyncSocketType: SocketType {

}

extension ReceiveAsyncSocketType {

    /// Creates and returns a `SocketDispatchSource` that calls the given `readyToReceiveHandler`
    /// whenever data is available. One of the `receive()` methods can then be called without blocking.
    ///
    /// To stop receiving data asynchronously, call `cancel()` on the returned `SocketDispatchSource`. 
    /// This also happens automatically in the `SocketDispatchSource.deinit`.
    ///
    /// - Returns: A `SocketDispatchSource` that must be held on to by the caller for as long as callbacks are to be received.
    func receiveAsync(queue queue: dispatch_queue_t = dispatch_get_global_queue(0, 0), readyToReceiveHandler: () -> Void) -> SocketDispatchSource {
        return SocketDispatchSource(socket: socket, queue: queue, eventHandler: readyToReceiveHandler)
    }
    
}
