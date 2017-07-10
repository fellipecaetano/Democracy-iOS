import XCTest
import Nimble

class GeneratorTests: XCTestCase {
    func testGeneratedArray() {
        let count = 3
        let value = "generated value"
        expect(Array(self.generator(count: count, value: value))) == Array(repeating: value, count: count)
    }

    private func generator<T>(count: Int, value: T) -> Generator<T> {
        return Generator(count: count) { value }
    }
}
