extension Array where Element: Equatable {
    func removing(_ element: Element) -> [Element] {
        if let index = index(of: element) {
            var copy = self
            copy.remove(at: index)
            return copy
        } else {
            return self
        }
    }
}

extension Array {
    func appending(_ element: Element) -> [Element] {
        var copy = self
        copy.append(element)
        return copy
    }
}
