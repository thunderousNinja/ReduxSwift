//
//  Middlewares.swift
//  ReduxSwift
//
//  Created by Jonathan Garcia on 12/2/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

func loggingMiddleware(store: MiddlewareStore) -> DispatchFunction {
    return { (next: Dispatch) -> Dispatch in
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