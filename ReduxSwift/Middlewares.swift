//
//  Middlewares.swift
//  ReduxSwift
//
//  Created by Jonathan Garcia on 12/2/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias MiddlewareReturnFunction = (StoreDispatchFunction) -> StoreDispatchFunction
typealias MiddlewareFunction = (store: MiddlewareStore) -> MiddlewareReturnFunction

func loggingMiddleware(store: MiddlewareStore) -> MiddlewareReturnFunction {
    return { (next: StoreDispatchFunction) -> StoreDispatchFunction in
        return { (action: Action) -> Action in
            print("---")
            print("prev state: \(store.getState())")
            print("action: \(action)")
            let returnValue = try next(action: action)
            print("next state: \(store.getState())")
            print("---")
            return returnValue
        }
    }
}