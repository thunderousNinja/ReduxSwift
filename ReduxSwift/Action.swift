//
//  Action.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias Payload = Any

struct ActionTypes {
    static let Init = "Init"
}

class Action: CustomStringConvertible {
    var payload: Payload?
    var type: String
    
    init(payload: Payload?, type: String) {
        self.payload = payload;
        self.type = type;
    }
    
    var description: String {
        return "[\"type\": \(self.type), \"payload\": \(self.payload)]"
    }
}