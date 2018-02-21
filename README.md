# Bitrise API for Swift
> A framework for connecting to the Bitrise API, which allows you to access your accounts Apps, Builds, and Artifacts. 
> This framework is by no means developed by or in any way associated with Bitrise

[![Swift Version][swift-image]][swift-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Features

- [x] Get your apps
- [x] Get builds for your apps
- [x] Get artifacts for your builds
- [x] Abort builds
- [x] Support for all current endpoints provided by the Bitrise API
- [x] Support for iOS, macOS and tvOS 

## Requirements

- iOS 9.0+

## Installation

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/BitriseAPI.framework` to an iOS project.

```
github "joeltrew/BitriseAPI-Swift"
```
#### Manually
Download and drop ```BitriseAPI.xcodeproject``` in your project.  

#### CocoaPods
Not at the moment, open to a PR


## Usage example


[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/