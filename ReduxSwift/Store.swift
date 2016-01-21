//
//  Store.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias StoreDispatchFunction = (action: Action) throws -> Action
typealias StoreGetStateFunction = () -> Any
typealias StoreSubscribeFunction = (subscribe: EmptyFunction) -> EmptyFunction

public class Store {
    var dispatch: StoreDispatchFunction
    var getState: StoreGetStateFunction
    var subscribe: StoreSubscribeFunction?
    
    init(dispatch: StoreDispatchFunction, getState: StoreGetStateFunction, subscribe: StoreSubscribeFunction?) {
        self.dispatch = dispatch
        self.getState = getState
        self.subscribe = subscribe
    }
}

public class MiddlewareStore {
    var dispatch: StoreDispatchFunction
    var getState: StoreGetStateFunction
    
    init(dispatch: StoreDispatchFunction, state: StoreGetStateFunction) {
        self.dispatch = dispatch
        self.getState = state
    }
}