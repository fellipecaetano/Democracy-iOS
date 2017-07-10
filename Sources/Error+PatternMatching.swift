import Foundation

func ~= (lhs: Error, rhs: Error) -> Bool {
    let _lhs = lhs as NSError
    let _rhs = rhs as NSError
    return _lhs.code == _rhs.code && _lhs.domain == _rhs.domain
}

func ~= (lhs: Error?, rhs: Error?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs ~= rhs
    } else if lhs == nil && rhs == nil {
        return true
    } else {
        return false
    }
}
