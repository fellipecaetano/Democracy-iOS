
enum CounterAction: Action {
    case increment
    case decrement
}

func counterReducer(state: Int, action: Action) -> Int {
    switch action {
    case CounterAction.increment:
        return state + 1
    case CounterAction.decrement:
        return state - 1
    default:
        return state
    }
}

let counterStore = Store(initialState: 0, reducer: counterReducer)

counterStore.dispatch(CounterAction.increment)

_ = counterStore.subscribe { newCounterState in

    print(newCounterState)
}

counterStore.dispatch(CounterAction.decrement)
