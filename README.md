# Bitrise API for Swift
> A framework for connecting to the [Bitrise API](http://devcenter.bitrise.io/api/v0.1/), which allows you to access your accounts Apps, Builds, and Artifacts. 

This framework is not developed by or in any way associated with Bitrise ltd (bitrise.io)

[![Swift Version][swift-image]][swift-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SwiftPackage compatible](https://img.shields.io/badge/SwiftPackage-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)


## Features

- [x] Get your apps
- [x] Get builds for your apps
- [x] Get artifacts for your builds
- [x] Abort builds
- [x] Full pagination support for results
- [x] Supports query filters for the builds endpoint  
- [x] Support for iOS, macOS and tvOS (Latter two may need testing)

You can track the progress of Bitrise's API [here](https://discuss.bitrise.io/t/bitrise-io-api-v0-1-work-in-progress/1554)

## Requirements

- iOS 9.0+
- Swift 5.0+

## Installation

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/BitriseAPI.framework` to an iOS project.

```
github "joeltrew/BitriseAPI-Swift" ~> 1.0
```

#### Swift Package Manager
Add the following dependency to your `Package.swift` manifest:

```
dependencies: [
    .Package(url: "https://github.com/joeltrew/BitriseAPI-Swift", majorVersion: 1)
]
```

#### Manually
Download and drop ```BitriseAPI.xcodeproject``` in your project.  

#### CocoaPods
Not at the moment, open to a PR


## Usage example

```swift
        // Create a BitriseService object using your user token
        service = BitriseService(userToken: "your_api_token_here")
        
        // Call methods on the object
        // Getting an app by a specific slug
        service?.getAppBySlug("The_slug/id_of_your_app", completion: { (appResult) in
            if case let .success(apps) = appResult {
                print("App if request was a success: ", app)
            }
        })
```

```swift
        // Listed content is returned wrapped in a `PagedData` wrapper which includes pagination details
        service?.getApps(completion: { (pagedAppsResult) in
            
            switch pagedAppsResult {
            case .success(let pagedApps):
    
                print("Pagination metadata: ", pagedApps.pagination)
                print("Array fo apps: ", pagedApps.data)
                
            case .failure(let error):
                print("Handle the error in some way")
            }
        })
```     
```swift
        // You can supply a pagination object for endpoints that support it
        let pagination = Pagination(pageItemLimit: 10, next: "29e37a4844dda34b")
        
        // The get builds enpoint supports providing a query object, which allows you to filter results
        // For example:  only retuning successful builds
        var buildFilterQuery = BuildFilterQuery()
        buildFilterQuery.status = .finished(.success)
        
        service?.getBuildsForApp(app, pagination: pagination, filterQuery: buildFilterQuery, completion: { (buildsResult) in
            if case let .success(builds) = buildsResult {
                print("Builds: ", builds.data)
            }
        })
```



[swift-image]:https://img.shields.io/badge/Swift-5.0-F16D39.svg?style=flat
[swift-url]: https://swift.org/
