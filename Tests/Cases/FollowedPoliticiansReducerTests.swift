import XCTest
import Nimble
import RandomKit
@testable import Democracy

class FollowedPoliticiansReducerTests: XCTestCase {
    private let initiallyFollowedPoliticians = TestData.politicians(count: 5)
    private let reducer = curry(flip(FollowedPoliticiansReducer))

    func testStateTransitionsWhenPoliticianIsMarked() {
        let markedPolitician = initiallyFollowedPoliticians.last!

        let transitions: [Transition<[Politician]>] = [
            initiallyFollowedPoliticians => initiallyFollowedPoliticians.removing(markedPolitician),
            initiallyFollowedPoliticians.removing(markedPolitician) => initiallyFollowedPoliticians
        ]

        expect(self.reducer(FollowedPoliticiansAction.mark(markedPolitician))).to(applyTransitions(transitions))
    }
}
