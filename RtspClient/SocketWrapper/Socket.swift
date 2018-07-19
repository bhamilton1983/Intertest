//
//  Socket.swift
//  SocketWrapper
//
//  Created by Christian Ludl on 2016-02-09.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Darwin

/// A low-level wrapper around a POSIX socket, i.e. a file descriptor typed as `Int32`.
///
/// Provides wrapper methods for calling various socket functions that `throw` a `Socket.Error`
/// instead of returning `-1` and setting the global `errno`.
struct Socket {

    typealias Byte = UInt8

    /// The underlying file descriptor.
    let fileDescriptor: Int32

    /// Initializer for when a file descriptor exists already.
    init(fileDescriptor: Int32) {
        self.fileDescriptor = fileDescriptor
    }

    /// Initializer for creating a new file descriptor using `Darwin.socket()` using the `addrinfo`.
    init(addrInfo: addrinfo) throws {
        let fileDescriptor = Darwin.socket(addrInfo.ai_family, addrInfo.ai_socktype, addrInfo.ai_protocol)
        guard fileDescriptor != -1 else {
            throw Error.CreateFailed(code: errno)
        }
        self.init(fileDescriptor: fileDescriptor)
    }

}


/// Socket errors.
extension Socket {

    /// Most of these errors are thrown whenever a low level socket function returns `-1`.
    /// Their associated error code then provides detailed information on the error.
    enum Error: ErrorType, CustomStringConvertible {
        case BindFailed(code: errno_t)
        case CloseFailed(code: errno_t)
        case ConnectFailed(code: errno_t)
        case ConnectionClosed
        case CreateFailed(code: errno_t)
        case GetAddrInfoFailed(code: Int32)
        case GetNameInfoFailed(code: errno_t)
        case GetNameInfoInvalidName
        case ListenFailed(code: errno_t)
        case NoAddressAvailable
        case NoDataAvailable
        case ReceivedInvalidData
        case ReceiveFailed(code: errno_t)
        case SendFailed(code: errno_t)
        case AcceptFailed(code: errno_t)

        var description: String {
            func errorString(code: errno_t) -> String {
                return String(UTF8String: strerror(code))!
            }

            switch self {
            case .AcceptFailed(let code):
                return "accept() failed: " + errorString(code)

            case .BindFailed(let code):
                return "bind() failed: " + errorString(code)

            case .CloseFailed(let code):
                return "close() failed: " + errorString(code)

            case .ConnectionClosed:
                return "Connection closed."

            case .ConnectFailed(let code):
                return "connect() failed: " + errorString(code)

            case .CreateFailed(let code):
                return "socket() failed: " + errorString(code)

            case .GetAddrInfoFailed(let code):
                return "getaddrinfo() failed: " + String(UTF8String: gai_strerror(code))!

            case .GetNameInfoFailed(let code):
                return "getnameinfo() failed: " + errorString(code)

            case .GetNameInfoInvalidName:
                return "getnameinfo() returned invalid name."

            case .ListenFailed(let code):
                return "listen() failed: " + errorString(code)

            case .NoAddressAvailable:
                return "getaddrinfo() returned no address."

            case .NoDataAvailable:
                return "No data available"

            case .SendFailed(let code):
                return "send() failed: " + errorString(code)

            case .ReceivedInvalidData:
                return "Received invalid data"
                
            case .ReceiveFailed(let code):
                return "recv() failed: " + errorString(code)
            }
        }
    }

}


/// Sending data.
extension Socket {

    /// Sends the data in the given `buffer`.
    ///
    /// - SeeAlso: `send(2)`
    func send(buffer: UnsafeBufferPointer<Byte>, flags: Int32 = 0) throws -> Int {
        let result = Darwin.send(fileDescriptor, buffer.baseAddress, buffer.count, flags)
        guard result != -1 else {
            throw Error.SendFailed(code: errno)
        }
        return result
    }

    /// Sends the chunk of data defined by `pointer` and `count`.
    func send(pointer: UnsafePointer<Byte>, count: Int, flags: Int32 = 0) throws -> Int {
        return try send(UnsafeBufferPointer(start: pointer, count: count), flags: flags)
    }

}


// Receiving data.
extension Socket {

    /// Receives data into `buffer`.
    ///
    /// - Parameter buffer: A previously allocated buffer that this method writes into.
    /// - Parameter flags: Flags that are passed to `Darwin.recv()`.
    /// - Parameter blocking: If no data is available and...
    ///   - `blocking` is `true`: blocks until any data is available.
    ///   - `blocking` is `false`: throws `Socket.Error.NoDataAvailable`.
    ///
    /// - SeeAlso: `recv(2)`
    func receive(buffer: UnsafeMutableBufferPointer<Byte>, flags: Int32 = 0, blocking: Bool = false) throws -> Int {
        self[fileOption: O_NONBLOCK] = !blocking
        let bytesReceived = Darwin.recv(fileDescriptor, buffer.baseAddress, buffer.count, flags)
        guard bytesReceived != -1 else {
            switch errno {
            case EAGAIN:
                throw Error.NoDataAvailable

            case let error:
                throw Error.ReceiveFailed(code: error)
            }
        }
        guard bytesReceived != 0 else {
            throw Error.ConnectionClosed
        }
        return bytesReceived
    }

    /// Receives a chunk of data to `pointer` with a maximum of `count`.
    func receive(pointer: UnsafeMutablePointer<Byte>, count: Int, flags: Int32 = 0, blocking: Bool = false) throws -> Int {
        return try receive(UnsafeMutableBufferPointer(start: pointer, count: count), flags: flags, blocking: blocking)
    }

}


/// Closing the socket.
extension Socket {

    /// Closes the socket.
    ///
    /// - SeeAlso: `close(2)`
    func close() throws {
        guard Darwin.close(fileDescriptor) != -1 else {
            throw Error.CloseFailed(code: errno)
        }
    }
    
}


/// Server socket methods.
extension Socket {

    /// Binds the given address to the server socket.
    ///
    /// - SeeAlso: `bind(2)`
    func bind(address address: UnsafePointer<sockaddr>, length: socklen_t) throws {
        guard Darwin.bind(fileDescriptor, address, length) != -1 else {
            throw Error.BindFailed(code: errno)
        }
    }

    /// Starts listening for client connections on the server socket with type `SOCK_STREAM` (i.e. TCP).
    ///
    /// - SeeAlso: `listen(2)`
    func listen(backlog backlog: Int32) throws {
        guard Darwin.listen(fileDescriptor, backlog) != -1 else {
            throw Error.ListenFailed(code: errno)
        }
    }

    /// Accept a connection on the server socket and return. If no new client has connected and...
    ///  - `blocking` is `true`: blocks until a client connects.
    ///  - `blocking` is `false`: throws `Socket.Error.NoDataAvailable`.
    ///
    /// - SeeAlso: `accept(2)`
    func accept(blocking blocking: Bool = false) throws -> (Socket, SocketAddress) {
        self[fileOption: O_NONBLOCK] = !blocking

        var clientFileDescriptor: Int32 = 0
        let socketAddress = try SocketAddress() { sockaddr, length in
            clientFileDescriptor = Darwin.accept(fileDescriptor, sockaddr, length)
            guard clientFileDescriptor != -1 else {
                switch errno {
                case EAGAIN:
                    throw Error.NoDataAvailable

                case let error:
                    throw Error.AcceptFailed(code: error)
                }
            }
        }
        return (Socket(fileDescriptor: clientFileDescriptor), socketAddress)
    }

}


/// Client socket methods.
extension Socket {

    /// Connects the socket to a peer.
    ///
    /// - SeeAlso: `connect(2)`
    func connect(address address: UnsafePointer<sockaddr>, length: socklen_t) throws {
        guard Darwin.connect(fileDescriptor, address, length) != -1 else {
            throw Error.ConnectFailed(code: errno)
        }
    }

}

/// Subscripts.
extension Socket {

    /// A wrapper around `getsockopt()` and `setsockopt` with a level of `SOL_SOCKET`.
    ///
    /// - SeeAlso: `getsockopt(2)`
    ///
    /// - This should probably be a method that can throw.
    subscript(socketOption option: Int32) -> Int32 {

        get {
            var value: Int32 = 0
            var valueLength = socklen_t(sizeofValue(value))

            guard getsockopt(fileDescriptor, SOL_SOCKET, option, &value, &valueLength) != -1 else {
                let errorNumber = errno
                print("getsockopt() failed for option \(option). \(errorNumber) \(strerror(errorNumber))")
                return 0
            }

            return value
        }

        nonmutating set {
            var value = newValue

            guard setsockopt(fileDescriptor, SOL_SOCKET, option, &value, socklen_t(sizeofValue(value))) != -1 else {
                let errorNumber = errno
                print("setsockopt() failed for option \(option), value \(value). \(errorNumber) \(strerror(errorNumber))")
                return
            }
        }
        
    }

    /// A wrapper around `fcntl()` for the  `F_GETFL` and `F_SETFL` commands.
    ///
    /// - SeeAlso: `fcntl(2)`
    ///
    /// - This should probably be a method that can throw.
    subscript(fileOption option: Int32) -> Bool {

        get {
            let allFlags = fcntl(fileDescriptor, F_GETFL)
            guard allFlags != -1 else {
                let errorNumber = errno
                print("fcntl() failed for F_GETFL, option: \(option). \(errorNumber) \(strerror(errorNumber))")
                return false
            }

            return (allFlags & option) != 0
        }

        nonmutating set {
            var flags = fcntl(fileDescriptor, F_GETFL)
            guard flags != -1 else {
                let errorNumber = errno
                print("fcntl() failed for F_GETFL, option: \(option). \(errorNumber) \(strerror(errorNumber))")
                return
            }

            if newValue {
                flags |= option
            } else {
                flags &= ~option
            }

            guard fcntl(fileDescriptor, F_SETFL, flags) != -1 else {
                let errorNumber = errno
                print("fcntl() failed for F_SETFL, option: \(option). \(errorNumber) \(strerror(errorNumber))")
                return
            }
        }

    }

}
