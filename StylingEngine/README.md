# iOS ViewStyling Proposition
This project contains an example how stylesheets / styledefinitions can be used within an iOS project

## Stylesheet
All value definitions used to build up a style are written in `Stylesheet.swift` and it should be the only place they are defined.
These value definitions can be;
* Numbers
* Colors
* Fonts

Note; To sync more with Zeplin `Styleguide` might be a better name?

``` swift
struct Stylesheet {
    struct Dimensions {
        static let spacer: CGFloat(5)
    }

    struct Colors {
        static let red: UIColor.red
        static let blue: UIColor.blue
    }

    struct Fonts {
        static let header: UIFont.systemFont(size: 14)
    }
}
```

## ViewStyle

A ViewStyle is actually a closure which can be executes on a certain view type. The ViewStyle defines on what kind of views it can be executed using it's `View` generic type.

``` swift
extension ViewStyling where View == UILabel {
    static var headerLabel = ViewStyling {
        $0.font = Stylesheet.Fonts.header
        $0.textColor = Stylesheet.Colors.red
    }
}
```

Styles can also be nested:
``` swift
extension ViewStyling where View == UIView {
    static var exampleView = ViewStyling {
        $0.backgroundColor = Stylesheet.Colors.blue
    }
}

extension ViewStyling where View == UILabel {
    static var exampleLabel = ViewStyling {
        $0.style(as: .exampleView)
        $0.font = Stylesheet.Fonts.header
        $0.textColor = Stylesheet.Colors.red
    }
}
```

### Applying a style

A ViewStyle can be applied with only one line of code;
``` swift
label.style(as: .headerLabel)
```

``` objective-c
[label styleAs: JMBViewStyleHeaderLabel];
```

## Objective-C

Boilerplate for Objective-C is generated using `Sourcery`, check out `.sourcery.yml`, `Stylesheet.stencil` and `ViewStyle.stencil` how this is done. Sourcery has been added into the build phases to make sure all files are always up to date.
Note: Input & output files are not yet defined in the build phase, something to do for the eventual implementation.