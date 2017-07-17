import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let panel = CounterPanelView()
PlaygroundPage.current.liveView = panel

//

let counter = Variable<Int>(0)

_ = counter.asObservable().subscribe(onNext: { value in
    print(value)
})
