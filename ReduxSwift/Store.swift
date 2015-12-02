//
//  Store.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias Dispatch = (action: Action) throws -> Action
typealias Empty = () -> Void
typealias Reducer = (previousState: State, action: Action) -> State
typealias State = Any
typealias StoreState = () -> State
typealias Subscribe = (subscribe: Empty) -> Empty

class Store {
    var dispatch: Dispatch
    var state: StoreState
    var subscribe: Subscribe?
    
    init() {
        self.dispatch = defaultDispatch
        self.state = defaultState
    }
    
    init(dispatch: Dispatch, state: () -> State, subscribe: Subscribe) {
        self.dispatch = dispatch
        self.state = state
        self.subscribe = subscribe
    }
}

func defaultDispatch(action: Action) throws -> Action {
   return Action()
}

func defaultState() -> State {
    return [String: Any]()
}