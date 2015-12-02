//
//  ReduxSwiftTests.swift
//  ReduxSwiftTests
//
//  Created by Jonathan Garcia on 12/2/15.
//  Copyright © 2015 wasbee. All rights reserved.
//

import XCTest
@testable import ReduxSwift

class ReduxSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of
        // each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of
        // each test method in the class.
        super.tearDown()
    }
    
    func testInitialStateNotNil() {
        let state: State = initialState()
        XCTAssertNotNil(state)
    }
    
    func testCreateStoreNotNil() {
        let combinedReducer = Redux.combineReducers([
            "count": countReducer,
            "name": nameReducer,
            ])
        let store = Redux.createStore(initialState(), reducer: combinedReducer)
        XCTAssertNotNil(store)
    }
    
    func testIncrementCount() {
        let combinedReducer = Redux.combineReducers([
            "count": countReducer,
            "name": nameReducer,
            ])
        let store: Store = Redux.createStore(initialState(), reducer: combinedReducer)
        var state = appState(store)
        do {
            XCTAssertTrue(state["count"] as! Int == 0)
            try store.dispatch(action: Action(payload: nil, type: "Increment"))
            
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 1)
            
            try store.dispatch(action: Action(payload: nil, type: "Increment"))
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 2)
            
            try store.dispatch(action: Action(payload: nil, type: "Increment"))
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 3)
        } catch {
            XCTAssertTrue(false, "Failed to increment")
        }
    }
    
    func testIncrementAndDecrementCount() {
        let combinedReducer = Redux.combineReducers([
            "count": countReducer,
            "name": nameReducer,
            ])
        let store: Store = Redux.createStore(initialState(), reducer: combinedReducer)
        var state = appState(store)
        do {
            XCTAssertTrue(state["count"] as! Int == 0)
            
            try store.dispatch(action: Action(payload: nil, type: "Increment"))
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 1)
            
            try store.dispatch(action: Action(payload: nil, type: "Increment"))
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 2)
            
            try store.dispatch(action: Action(payload: nil, type: "Decrement"))
            state = appState(store)
            XCTAssertTrue(state["count"] as! Int == 1)
        } catch {
            XCTAssertTrue(false, "Failed to increment/decrement")
        }
    }
    
    func testChangeName() {
        let combinedReducer = Redux.combineReducers([
            "count": countReducer,
            "name": nameReducer,
            ])
        let store: Store = Redux.createStore(initialState(), reducer: combinedReducer)
        var state = appState(store)
        do {
            XCTAssertTrue(state["name"] as! String == "jon")
            
            try store.dispatch(action: Action(payload: "jonathan", type: "Change"))
            state = appState(store)
            XCTAssertTrue(state["name"] as! String == "jonathan")
        } catch {
            XCTAssertTrue(false, "Failed to change name")
        }
    }
    
    func countReducer(previousState: Any, action: Action) -> Int {
        var count = previousState as! Int;
        
        switch action.type {
        case "Increment":
            count += 1
            break
        case "Decrement":
            count -= 1
            break
        default:
            break
        }
        
        return count
    }
    
    func appState(store: Store) -> AppState {
        return store.state() as! AppState
    }
    
    func nameReducer(previousState: Any, action: Action) -> String {
        var name = previousState as! String;
        
        switch action.type {
        case "Change":
            name = action.payload as! String
            break
        default:
            break
        }
        
        return name
    }
    
    func initialState() -> [String: Any] {
        return [
            "count" : 0,
            "name" : "jon"
        ]
    }
    
}
