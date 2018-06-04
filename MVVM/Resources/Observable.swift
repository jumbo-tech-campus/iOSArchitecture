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
