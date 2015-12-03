# ReduxSwift
A redux implementation in Swift 

## Usage

### Creating reducers

```swift
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

func nameReducer(previousState: Any, action: Action) -> String {
    var name = previousState as! String;        
    
    switch action.type {
    case "ChangeName":
        name = action.payload as! String
        break
    default:
        break
    }        
    
    return name
}

// Create the combined reducer (If you have multiple reducers)
let combinedReducer = Redux.combineReducers([
    "count": countReducer,
    "name": nameReducer,
])
```
### Creating stores

```swift
import ReduxSwift

// Create the initial state
let initialState = [
    "count": 0,
    "name": "Jon Snow"
]

// Create the store
let store = Redux.createStore(
    initialState, 
    reducer: combinedReducer
)

```

### Dispatching Actions

```swift

// Initial state
let appState = store.getState() as! [String: Any]
print(appState["count"]) // 0
print(appState["name"]) // Jon Snow

// Dispatch an action to change the name
store.dispatch(action: Action(payload: "Tyrion Lannister", type: "ChangeName"))
appState = store.getState() as! [String: Any]
print(appState["name"]) // Tyrion Lannister

// Dispatch an action to increment the count
store.dispatch(action: Action(payload: nil, type: "Increment"))
appState = store.getState() as! [String: Any]
print(appState["count"]) // 1

// Dispatch an action to decrement the count
store.dispatch(action: Action(payload: nil, type: "Decrement"))
appState = store.getState() as! [String: Any]
print(appState["count"]) // 0

```

### Subscribing/Unsubscribing to the store

```swift
// Subscribe to store changes
let unsubscribe = store.subscribe() {
    // handle store changes here
}

// Unsubscribe to store changes
unsubscribe()
```

### Creating & applying middleware

```swift

// Create the middleware function

func loggingMiddleware(store: MiddlewareStore) -> DispatchFunction {
    return { (next: Dispatch) in
        return { (action: Action) in
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

// Apply the middleware

let storeEnhancer = Redux.applyMiddleware([loggingMiddleware])
let storeMaker = storeEnhancer(Redux.createStore)

// Create the store from the created `storeMaker` function

let store = storeMaker(
    initialState: initialState(), 
    reducer: combinedReducer
)

// Use the store

store.dispatch(action: Action(payload: nil, type: "Increment"))
// Output in console: 
//
// ---
// prev state: ["count": 0, "name": "Jon Snow"]
// action: ["type": Increment, "payload": nil]
// next state: ["count": 1, "name": "Jon Snow"]
// ---

```
