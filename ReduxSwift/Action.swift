//
//  Action.swift
//  redux
//
//  Created by Jonathan Garcia on 12/1/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import Foundation

typealias Payload = Any

struct Types {
    static let Empty = "Empty"
}

class Action {
    var payload: Payload?
    var type: String
    
    init(payload: Payload?, type: String) {
        self.payload = payload;
        self.type = type;
    }
    
    init() {
        self.type = Types.Empty
    }
}