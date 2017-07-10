typealias Transition<T> = (from: T, to: T)

precedencegroup TransitionPrecedenceGroup {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

infix operator => : TransitionPrecedenceGroup

func => <T> (lhs: T, rhs: T) -> Transition<T> {
    return (lhs, rhs)
}
