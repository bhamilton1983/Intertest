//
//  SendReceiveSocketType.swift
//  SocketWrapper
//
//  Created by Marco Masser on 2016-03-11.
//  Copyright © 2016 Objective Development. All rights reserved.
//

/// A socket that can `send()` and `receive()` (synchronously and asynchronously).
///
/// This is just a grouping of different protocols to allow them being used as a return value.
protocol SendReceiveSocketType: SendSocketType, ReceiveSocketType, ReceiveAsyncSocketType {

}
