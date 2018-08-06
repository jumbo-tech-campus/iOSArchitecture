# iOS Networking
This project contains a genric networking setup for Swift, but can also be called upon from Objective-C.

Key in this proposal are;
* Only 1 class will build requests
* Only 1 class will execute requests
* Only 1 class will parse requests

The proposal is build upon
* Protocol Oriented Programming
* SOLID's separation of concerns

Together they make the code fully testable and can be developed & expanded test-driven.

## Architecture

All possible requests are defined as an `ApiCall`, which is an enum consisting of groups of calls (i.e. `product` calls & `user` calls). This `ApiCall` class is used by `RequestBuilding` to define a protocol to create the requests.

The `RequestBuilding` protocol is implemented by `UxApiRequestBuilder`, which will define all `RequestSpecification` instances to create the requests from.
`RequestSpecification` is a struct with a lot of default values for it's init method, making it handy and compact in use for the `RequestBuilder`.

`RequestExecutor` is the class which will actually trigger the calls and will execute them via `RequestClient`. RequestClient is a protocol to wrap arround URLSession, giving us the ability to quickly replace the HTTP framework we use with i.e. `Alamofire`.

`ResponseParser`, which implemented in `UxApiResponseParser`, which parses the data retrieved by `RequestExecutor`. For each `ApiCall` there will be a dedicated method to call and parse the data.

Last we have 

Note; Naming is mostly derived from the VIP architecture. All naming is up for change.

## Dataflow

The usual flow to using this proposal would be;
1. Create an instance of `GatewayProducing`, i.e. in a `DependencyComposition` pattern
2. Request the `GatewayProducing` instance to create the gateway
3. Call `execute` on the produced gateway
4. In `execute`'s completion block handle the data as nessecary

When a `GatewayProducing` creates a gateway, it will;
1. Create an instance of `RequestBuilding`
2. Create an instance of `RequestExecuting`
3. Create an instance of `RequestParsing`
4. Create an instance of `RequestGateway`, passing the builder, executor & parser to it.

When a `RequestGateway` is executed, it will;
1. Ask the `RequestBuilding` to produce the request to execute
2. Execute the build request via `RequestExecuting`
3. Parse the data via `ResponseParsing`
4. Call it's completion closure with the result of `3.`


## Objective-C support
All magic is, and will be, written in Swift. The only thing Objective-C needs to be able to interact with are;
* GatewayFactory
* Gateway's execute method

As the result type of the execute method of a `Gateway` is derived from a generic, we can't directly annotate the execute method with `@objc` as it can't be expressed in `Objective-C`. To overcome this a method `objcExecute` has been added to the `Gateway` protocol, which can be used from Objective-C callers. Usage of the method is exactly the same as the normal `execute` method.

## Notes

### Try/Catch & errror handling
You might have noticed there are a number of `try` and `throw` keywords in there. Correct and complete error handling will be a challenge and there will be `do {} catch {}` closures throughtout the codebase.
I'd recommend us to start using [RxSwift](https://github.com/ReactiveX/RxSwift) to overcome this, but also the need of generic app boilerplate.

### RequestExecutor
You've probably noticed `RequestExecutor` is currently only an adapter between gatways and the `RequestClient` which was chosen. It actually adds one extra, the default paramter in the init method; It gives us one line of code to change the HTTP request library used throughout the whole project.
Extra `ReqeustExecutor` could be the starting point to wrap the output from `RequestClient` into an `Observable` pattern.

### Performing action after request execution

With the current implementation implementing something like caching would happen on each location where a certain `Gateway` is used, which is not prefered.
To overcome this the `Gateway` could be wrapped into an `Interactor`

## Installation

```
$ git clone https://github.com/jumbo-tech-campus/iOSArchitecture
$ cd iOSArchitecture/Networking
$ pod install
$ open Networking.xcworkspace
```