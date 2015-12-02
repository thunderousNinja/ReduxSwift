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
let appState = store.state() as! [String: Any]
print(appState["count"]) // 0
print(appState["name"]) // Jon Snow

// Dispatch an action to change the name
store.dispatch(action: Action(payload: "Tyrion Lannister", type: "ChangeName"))
appState = store.state() as! [String: Any]
print(appState["name"]) // Tyrion Lannister

// Dispatch an action to increment the count
store.dispatch(action: Action(payload: nil, type: "Increment"))
appState = store.state() as! [String: Any]
print(appState["count"]) // 1

// Dispatch an action to decrement the count
store.dispatch(action: Action(payload: nil, type: "Decrement"))
appState = store.state() as! [String: Any]
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

## TODOs

- [ ] More tests
- [ ] Carthage support 
- [ ] CocoaPods support 
- [ ] Middleware support 
