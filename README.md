# iOS Architecture Experimentation
This project provides simplified implementations of common iOS design and architectural patterns for experimentation.

## MVVM
The `MVVM` target provides an example o  how MVVM could be implemented and showcases some handy techniques to remove iOS boiler plate code. A related test target shows how just testing the ViewModel covers the complete business logic, including oftern ignored UI data when implementing `MVC`.

## Navigation, initialization & Dependency "Composition" with FlowControllers
Navigation is business logic that can bring many complex rules based on the current app state. Navigate to X when user has Y, navigate 3 screens back with these models when the app looks like Z. `FlowControllers` solve this, while also making sure each instantiated `ViewModel` or `ViewController` has the right dependencies. 


## Simplified Observing (without React)
An example of how the observer pattern could be implemented without the full RxSwift library. The simple possibility of connecting an event (network fetch) to an other update (UI refresh) can be very powerful.

``` swift
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

let observableInt = Observable<Int>(0)

observableInt.observe {
    // Synchronize UI
    print("Value changed: \($0)")
}

// Some time in the future
observableInt.value = 1

// Value changed: 0
// Value changed: 1
```
