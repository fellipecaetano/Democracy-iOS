struct Generator<T>: IteratorProtocol, Sequence {
    private let count: Int
    private let _next: () -> T
    private var index = 0

    init (count: Int, _ next: @escaping () -> T) {
        self.count = count
        _next = next
    }

    mutating func next() -> T? {
        index += 1
        return (index > count) ? nil : _next()
    }
}
