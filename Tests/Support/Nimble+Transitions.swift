import Nimble

func applyTransitions<T: Equatable>(_ transitions: [Transition<T>]) -> Predicate<(T) -> T> {
    return Predicate { actualExpression in
        if let transform = try actualExpression.evaluate() {
            let failedTransitions: String = transitions.enumerated().reduce([], { failures, iteration in
                if transform(iteration.element.from) != iteration.element.to {
                    return failures + [iteration.offset.description]
                } else {
                    return failures
                }
            }).joined(separator: ", ")

            let failureMessage = ExpectationMessage.fail("transitions numbered \(failedTransitions) failed")
            return PredicateResult(bool: failedTransitions.isEmpty, message: failureMessage)
        } else {
            let messageWhenNil = ExpectationMessage.fail("expected a state transformation").appendedBeNilHint()
            return PredicateResult(status: .fail, message: messageWhenNil)
        }
    }
}
