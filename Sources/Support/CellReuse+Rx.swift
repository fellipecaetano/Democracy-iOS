import RxSwift

extension Reactive where Base == UITableView {
    func rows<S: Sequence,
              C: UITableViewCell,
              O: ObservableType>
        (ofType cellType: C.Type)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, C) -> Void)
        -> Disposable where O.E == S, C: Reusable {
            return { source in
                return { configureCell in
                    return self.items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)(source)(configureCell)
                }
            }
    }
}
