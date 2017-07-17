import Nimble

func applyTransitions<T: Equatable>(_ transitions: [Transition<T>]) -> Predicate<(T) -> T> {
    return Predicate { actualExpression in
        if let transform = try actualExpression.evaluate() {
            let failedTransitions = failures(applying: transform, to: transitions)
            let failureMessage = message(forFailedTransitions: failedTransitions)
            return PredicateResult(bool: failedTransitions.isEmpty, message: failureMessage)
        } else {
            let messageWhenNil = ExpectationMessage.fail("expected a state transformation").appendedBeNilHint()
            return PredicateResult(status: .fail, message: messageWhenNil)
        }
    }
}

private func failures<T: Equatable>(applying transform: (T) -> T, to transitions: [Transition<T>]) -> [Int] {
    return transitions.enumerated().reduce([]) { failures, iteration in
        if transform(iteration.element.from) != iteration.element.to {
            return failures + [iteration.offset]
        } else {
            return failures
        }
    }
}

func applyTransitions<T: Equatable>(_ transitions: [Transition<[T]>]) -> Predicate<([T]) -> [T]> {
    return Predicate { actualExpression in
        if let transform = try actualExpression.evaluate() {
            let failedTransitions = failures(applying: transform, to: transitions)
            let failureMessage = message(forFailedTransitions: failedTransitions)
            return PredicateResult(bool: failedTransitions.isEmpty, message: failureMessage)
        } else {
            let messageWhenNil = ExpectationMessage.fail("expected a state transformation").appendedBeNilHint()
            return PredicateResult(status: .fail, message: messageWhenNil)
        }
    }
}

private func failures<T: Equatable>(applying transform: ([T]) -> [T], to transitions: [Transition<[T]>]) -> [Int] {
    return transitions.enumerated().reduce([]) { failures, iteration in
        if transform(iteration.element.from) != iteration.element.to {
            return failures + [iteration.offset]
        } else {
            return failures
        }
    }
}

private func message(forFailedTransitions failures: [Int]) -> ExpectationMessage {
    let failureString = failures.map({ $0.description }).joined(separator: ", ")
    return ExpectationMessage.fail("transitions numbered \(failureString) failed")
}
