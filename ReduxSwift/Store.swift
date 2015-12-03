//
//  Store.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

public class Store {
    var dispatch: Dispatch
    var getState: StoreState
    var subscribe: Subscribe?
    
    init(dispatch: Dispatch, getState: () -> State, subscribe: Subscribe?) {
        self.dispatch = dispatch
        self.getState = getState
        self.subscribe = subscribe
    }
}

public class MiddlewareStore {
    var dispatch: Dispatch
    var getState: StoreState
    
    init(dispatch: Dispatch, state: () -> State) {
        self.dispatch = dispatch
        self.getState = state
    }
}