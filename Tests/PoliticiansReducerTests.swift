import XCTest
import Nimble
@testable import Democracy

class PoliticiansReducerTests: XCTestCase {
    func testStateTransitions() {
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
        return PoliticiansState(data: [], isLoading: false, error: error)
    }
}
