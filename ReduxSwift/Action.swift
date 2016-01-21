//
//  Action.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias ActionPayload = AnyObject
typealias ActionType = String

struct ActionTypes {
    static let Init = "Init"
}

protocol Action {
    var payload: ActionPayload? { get set }
    var type: ActionType { get set }
    init(payload: ActionPayload?, type: ActionType)
}

struct StandardAction: Action {
    var type: ActionType
    var payload: ActionPayload?
    init(payload: ActionPayload?, type: ActionType) {
        self.payload = payload
        self.type = type
    }
}