//
//  Redux.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

class Redux {
    
    /**
     Create a store enhancer that applies middleware to the dispatch method of
     the store
     
     - Parameter middlewares: The list of middlewares
     
     - Returns: A store enhancer applying the middleware to the dispatch method.
     */
    static func applyMiddleware(middlewares: [Middleware]) -> StoreEnhancer {
        
        return { (next: StoreMaker) -> StoreMaker in
            
            return { (initialState: State, reducer: Reducer) -> Store in
                let store = next(initialState: initialState, reducer: reducer)
                var dispatch = store.dispatch
                
                func wrappedDispatch(action: Action) throws -> Action {
                    return try dispatch(action: action)
                }
                
                let middlewareStore = MiddlewareStore(
                    dispatch: wrappedDispatch,
                    state: store.getState
                )
                
                let middlewareFunks = middlewares.map { ware in
                    ware(store: middlewareStore)
                }
                
                dispatch = compose(middlewareFunks)(store.dispatch)
                
                return Store(
                    dispatch: dispatch,
                    getState: store.getState,
                    subscribe: store.subscribe
                )
            }
            
        }
        
    }
    
    /**
     Reduces multiple reducer into a single reducer.
     
     - Parameter reducers: The list of reducers to combine.
     
     - Returns: A combined reducer.
    */
    static func combineReducers(reducers: [String: Reducer]) -> Reducer {
        var initialState = AppState();
        
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
    
    /**
     Creates a new store
     
     - Parameter initialState: The initial app state
     - Parameter reducer: The reducer used during dispatching.
     
     - Returns: The newly created store.
     */
    static func createStore(initialState: State, reducer: Reducer) -> Store {
        var dispatching = false
        var subscribers = [Empty]()
        var currentState = initialState

        func getState() -> State {
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
        
        do {
            try dispatch(StandardAction(payload: nil, type: ActionTypes.Init))
        } catch {
            print("Unable to dispatch Init action");
        }
        
        return Store(
            dispatch: dispatch,
            getState: getState,
            subscribe: subscribe
        )
    }
    
}