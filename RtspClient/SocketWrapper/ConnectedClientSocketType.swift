//
//  ConnectedClientSocketType.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-11.
//  Copyright © 2016 Objective Development. All rights reserved.
//

/// A client socket that was `accept()`ed by a `ServerSocketType`.
protocol ConnectedClientSocketType: AddressSocketType, SendReceiveSocketType {

}

/// A minimal implementation of the `ConnectedClientSocketType`.
struct ConnectedClientSocket: ConnectedClientSocketType {

    let socket: Socket
    let address: SocketAddress
    
}
