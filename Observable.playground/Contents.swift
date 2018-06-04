/*
    Observer pattern simplified

    - The Observable object is one of the core objects of reactive programming
    - With this simplified class we can implement the observer pattern for many scenario's
    - Connect data streams to UI updates (or different connections)
    - Make the connection once and the data flow exists until the object is deallocated
*/

import UIKit

class Observable<T> {
    typealias Event = (T) -> Void
    var event: Event?

    var value: T {
        didSet {
            event?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func observe(event: Event?) {
        self.event = event
        event?(value)
    }
}

class ViewModel {
    let observableString: Observable<String> = Observable("")

    func fetchNewString() {
        observableString.value = "new string \(arc4random_uniform(100))"
    }
}

class ViewController {
    let label = UILabel()
    var viewModel: ViewModel!

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        // Create the connection once
        viewModel.observableString.observe {
            self.label.text = $0
            print($0)
        }
    }
}

let viewModel = ViewModel()
let viewController = ViewController(viewModel: viewModel)

// After each data fetch, the UI updates itself automatically
viewModel.fetchNewString()
viewModel.fetchNewString()

viewModel.observableString.value = "Whatever"
