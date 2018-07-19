//
//  AddressInfoSequence.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-04.
//  Copyright © 2016 Objective Development. All rights reserved.
//

import Darwin

/// A wrapper around a `addrinfo` linked list.
///
/// - Important: When iterating over an `AddressInfoSequence` using its `SequenceType` conformance, the `addrinfo`
///   struct's internal pointers are only valid as long as the `GeneratorType` returned by `generate` is alive.
struct AddressInfoSequence {

    /// An internal storage that is used by `AddressInfoSequence` and its `SequenceType` implementation.
    private class Storage {

        /// The internal pointer to the head of the linked list.
        ///
        /// - Important: This pointer and the whole linked list - including all the `addrinfo`'s
        ///              internal pointers - are only valid as long as `self` is referenced.
        private let _addrInfoPointer: UnsafeMutablePointer<addrinfo>

        /// Creates an instance with an existing `UnsafeMutablePointer<addrinfo>`, taking ownership of it.
        init(addrInfoPointer: UnsafeMutablePointer<addrinfo>) {
            _addrInfoPointer = addrInfoPointer
        }

        deinit {
            freeaddrinfo(_addrInfoPointer)
        }
        
    }

    /// The internal storage for the `addrinfo` linked list.
    private let _addrInfoStorage: Storage

    /// Creates an instance intended for a server socket for the given `port` that will be used with `bind()`.
    ///
    /// - parameter family: Default: `AF_UNSPEC`, i.e. IP4 or IP6.
    /// - parameter socketType: Default: `SOCK_STREAM`, i.e. a TCP socket.
    /// - parameter flags: Default: `AI_PASSIVE`, i.e. set the IP address of the resulting `sockaddr` to `INADDR_ANY` (IPv4) or `IN6ADDR_ANY_INIT` (IPv6).
    init(forBindingToPort port: String, family: Int32 = AF_UNSPEC, socketType: Int32 = SOCK_STREAM, flags: Int32 = AI_PASSIVE) throws {
        try self.init(host: nil, port: port, family: family, socketType: socketType, flags: flags)
    }

    /// Creates an instance intended for a client socket for the given `host` and `port` that will be used with `connect()`.
    ///
    /// - parameter family: Default: `AF_UNSPEC`, i.e. IP4 or IP6.
    /// - parameter socketType: Default: `SOCK_STREAM`, i.e. a TCP socket.
    /// - parameter flags: Default: `AI_DEFAULT` (= `AI_V4MAPPED_CFG | AI_ADDRCONFIG`).
    init(forConnectingToHost host: String, port: String, family: Int32 = AF_UNSPEC, socketType: Int32 = SOCK_STREAM, flags: Int32 = AI_V4MAPPED_CFG | AI_ADDRCONFIG) throws {
        try self.init(host: host, port: port, family: family, socketType: socketType, flags: flags)
    }

    /// Creates an instance for the given `host` and/or `port`.
    ///
    /// - parameter family: For example `AF_UNSPEC`, i.e. IP4 or IP6.
    /// - parameter socketType: For example `SOCK_STREAM`, i.e. a TCP socket.
    /// - parameter flags: For example `AI_DEFAULT`.
    private init(host: String?, port: String?, family: Int32, socketType: Int32, flags: Int32) throws {
        var hints = addrinfo();
        hints.ai_family = family
        hints.ai_socktype = socketType
        hints.ai_flags = flags

        try self.init(host: host, port: port, hints: &hints)
    }

    /// Creates an instance by calling `getaddrinfo()` with the given arguments.
    ///
    /// Throws an error either if `getaddrinfo` failed, or if it returned an empty list. Therefore, if this initializer doesn't throw,
    /// the created instance is guaranteed to have at least one `addrinfo`.
    ///
    /// - Parameter host: The hostname or IP address to resolve. Pass `nil` when resolving addresses for a server socket.
    /// - Parameter port: The port or service name to resolve, e.g. "80" or "http". Pass `nil` when resolving an address
    ///   for a protocol that does not use ports, e.g. ICMP.
    /// - Parameter hints: A pointer to an `addrinfo` struct that is used as hints. This allows specifying things like
    ///   the protocol family, socket type, or protocol. May be `nil`.
    ///
    /// - Important: `host` and `port` are both optional, but at least one of them must be given.
    ///
    /// - Note: See `getaddrinfo(3)` for more details about the parameters.
    private init(host: String?, port: String?, hints: UnsafePointer<addrinfo>) throws {
        var addrInfoPointer: UnsafeMutablePointer<addrinfo> = nil
        let result: Int32

        // `String` bridges to `UnsafePointer<Int8>` automatically, but `String?` does not. This
        // switch takes care of the various combinations of `host` and `port` that can occur.
        switch (host, port) {
        case let (host?, port?):
            result = getaddrinfo(host, port, hints, &addrInfoPointer)

        case let (nil, port?):
            result = getaddrinfo(nil, port, hints, &addrInfoPointer)

        case let (host?, nil):
            result = getaddrinfo(host, nil, hints, &addrInfoPointer)

        default:
            preconditionFailure("Either host or port must be given")
        }

        guard result != -1 else {
            throw Socket.Error.GetAddrInfoFailed(code: result)
        }
        guard addrInfoPointer != nil else {
            throw Socket.Error.NoAddressAvailable
        }

        _addrInfoStorage = Storage(addrInfoPointer: addrInfoPointer)
    }

}


extension AddressInfoSequence: SequenceType {

    func generate() -> AddressInfoGenerator {
        return AddressInfoGenerator(storage: _addrInfoStorage)
    }

}

struct AddressInfoGenerator: GeneratorType {

    private let _storage: AddressInfoSequence.Storage
    private var _cursor: UnsafeMutablePointer<addrinfo>

    private init(storage: AddressInfoSequence.Storage) {
        _storage = storage
        _cursor = storage._addrInfoPointer
    }

    mutating func next() -> addrinfo? {
        guard _cursor != nil else {
            return nil
        }
        var addrInfo = _cursor.memory
        _cursor = addrInfo.ai_next
        addrInfo.ai_next = nil // Prevent access to the next element of the linked list.
        return addrInfo
    }

}

extension AddressInfoSequence {

    /// Calls `f` with a copy of the first `addrinfo` in the sequence.
    func withFirstAddrInfo<R>(@noescape f: (addrinfo) throws -> R) rethrows -> R {
        return try f(_addrInfoStorage._addrInfoPointer.memory)
    }

}


#if false // Doesn't work yet.
extension AddressInfoSequence: CustomStringConvertible {

    var description: String {
        return "[" + map { SocketAddress(addrInfo: $0).displayName }.reduce("") { $0 + ", " + $1 } + "]"
    }

}
#endif
