# ModuleArchitecture

This project shows a POC for a modular architecture in iOS based on CocoaPod (development) pods.
The project contains the following;

- UIModule: A basic framework to apply CSS-style styling to any UIView
- NetworkModule: A simple GET-request executor
- FeatureModule: An app project loading a single screen with text and an image

- ModuleArchitecture: The project wrapping all modules togheter.

ModuleArchitecture has a dependency on FeatureModule, which is started by tapping the button after starting ModuleArchitecture. 
ModuleArchitecture can also directly use UIModule & NetworkModule

FeatureModule is also using both UIModule & NetworkModule, and is configured to also be able to run as a standalone project.

All code is POC and should not be released.
