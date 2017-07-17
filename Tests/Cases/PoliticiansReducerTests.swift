import XCTest
import Nimble
@testable import Democracy

class PoliticiansReducerTests: XCTestCase {
    private let previousData = TestData.politicians(count: 5)
    private let previousError = TestData.error()
    private let reducer = curry(flip(PoliticiansReducer))

    func testStateTransitionsWhenLoadingStarts() {
        let transitions: [Transition<PoliticiansState>] = [
            .initial => .loading(),
            .loading() => .loading(),
            .loading(previousData: previousData) => .loading(previousData: previousData),
            .loaded(with: previousData) => .loading(previousData: previousData),
            .failed(error: previousError) => .loading(),
            .failed(error: previousError, previousData: previousData) => .loading(previousData: previousData)
        ]

        expect(self.reducer(PoliticiansAction.startLoading)).to(applyTransitions(transitions))
    }

    func testStateTransitionsWhenLoadingSucceeds() {
        let loadedData = TestData.politicians(count: 5)

        let transitions: [Transition<PoliticiansState>] = [
            .initial => .loaded(with: loadedData),
            .loading() => .loaded(with: loadedData),
            .loading(previousData: previousData) => .loaded(with: loadedData),
            .loaded(with: previousData) => .loaded(with: loadedData),
            .failed(error: previousError) => .loaded(with: loadedData),
            .failed(error: previousError, previousData: previousData) => .loaded(with: loadedData),
        ]

        expect(self.reducer(PoliticiansAction.load(loadedData))).to(applyTransitions(transitions))
    }

    func testStateTransitionsWhenLoadingFails() {
        let newError = TestData.error()

        let transitions: [Transition<PoliticiansState>] = [
            .initial => .failed(error: newError),
            .loading() => .failed(error: newError),
            .loading(previousData: previousData) => .failed(error: newError, previousData: previousData),
            .loaded(with: previousData) => .failed(error: newError, previousData: previousData),
            .failed(error: previousError) => .failed(error: newError),
            .failed(error: previousError, previousData: previousData) => .failed(error: newError, previousData: previousData)
        ]

        expect(self.reducer(PoliticiansAction.fail(newError))).to(applyTransitions(transitions))
    }

    func testStateTransitionsWhenUnknownActionIsDispatched() {
        struct UnknownAction: Action {}

        let transitions: [Transition<PoliticiansState>] = [
            .initial => .initial,
            .loading() => .loading(),
            .loading(previousData: previousData) => .loading(previousData: previousData),
            .loaded(with: previousData) => .loaded(with: previousData),
            .failed(error: previousError) => .failed(error: previousError),
            .failed(error: previousError, previousData: previousData) => .failed(error: previousError, previousData: previousData)
        ]

        expect(self.reducer(UnknownAction())).to(applyTransitions(transitions))
    }
}

private extension PoliticiansState {
    static func loaded(with data: [Politician]) -> PoliticiansState {
        return PoliticiansState(data: data, isLoading: false, error: nil)
    }

    static func loading(previousData: [Politician] = []) -> PoliticiansState {
        return PoliticiansState(data: previousData, isLoading: true, error: nil)
    }

    static func failed(error: Error, previousData: [Politician] = []) -> PoliticiansState {
        return PoliticiansState(data: previousData, isLoading: false, error: error)
    }
}
