//
//  Redux.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias AppState = [String: Any]

class Redux {
    
    /**
     Combines multiple reducers
    */
    static func combineReducers(reducers: [String: Reducer]) -> Reducer {
        var initialState = [String: Any]();
        
        func combined(state: State, action: Action) -> AppState {
            var appState = state as! AppState;
            for (name, reducer) in reducers {
                if let previousState = appState[name] {
                    appState[name] = reducer(
                        previousState: previousState,
                        action: action
                    )
                }
                
            }
            return appState
        }
        
        return combined
    }
    
    static func createStore(initialState: State, reducer: Reducer) -> Store {
        var dispatching = false
        var subscribers = [Empty]()
        var currentState = initialState

        func state() -> State {
            return currentState
        }
        
        func dispatch(action: Action) throws -> Action {
            if dispatching {
                throw Error.DispatchInFlightError
            }
            
            defer {
                dispatching = false // ensures we always reset the dispatching
            }
            
            dispatching = true
            currentState = reducer(previousState: currentState, action: action)
            for subscriber in subscribers {
                subscriber()
            }

            return action
        }
        
        func subscribe(subscribe: Empty) -> Empty {
            subscribers.append(subscribe)
            var index = subscribers.count - 1
            var subscribed = true
            
            func unsubscribe() {
                if !subscribed {
                    return
                }
                
                subscribed = false
                
                // need to set to a variable or a compile time error...
                _ = subscribers.removeAtIndex(index)
            }
            return unsubscribe
        }
        
        let store = Store()
        store.state = state
        store.dispatch = dispatch
        store.subscribe = subscribe
        return store
    }
    
}