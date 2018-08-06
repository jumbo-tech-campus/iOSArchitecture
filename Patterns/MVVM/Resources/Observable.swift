/*
    - An experimentational introduction into reactive programming
    - Observables expose data streams which can be observed by anyone interested
    - After each value update, a callback is triggered, updating the observing UI
*/

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
