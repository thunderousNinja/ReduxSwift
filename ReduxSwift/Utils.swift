//
//  Utils.swift
//  ReduxSwift
//
//  Created by Jonathan Garcia on 12/2/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias AppState = [String: Any]
typealias State = Any
typealias EmptyFunction = () -> Void

/**
 * Composes single-argument functions from right to left.
 * 
 * - Parameter funks: functions to compose.
 * 
 * - Returns: A function obtained by composing functions from right to
 * left. For example, compose(f, g, h) is identical to arg => f(g(h(arg))).
 */
public func compose<G>(funks: [(G) -> G]) -> (G) -> G {
    let reversed = funks.reverse() // no reduceRight in STL :[
    func compose(arg: G) -> G {
        return reversed.reduce(arg) { (composed: G, funk: (G) -> G) -> G in
            return funk(composed)
        }
    }
    return compose
}