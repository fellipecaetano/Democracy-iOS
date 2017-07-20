import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let panel = CounterPanelView()
PlaygroundPage.current.liveView = panel

//

let counter = Variable<Int>(0)

_ = panel.incrementButton.rx.tap
    .withLatestFrom(counter.asObservable())
    .map({ counter in
        return counter + 1
    })
    .bind(to: counter)

_ = panel.decrementButton.rx.tap
    .withLatestFrom(counter.asObservable())
    .map({ counter in
        return counter - 1
    })
    .bind(to: counter)

_ = counter.asObservable().subscribe(onNext: { value in
    print(value)
})
