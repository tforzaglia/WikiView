[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# WikiView
iOS framework that provides a `UIViewController` subclass for displaying contents of Wikipedia page

## Installation
### Carthage

WikiView is [Carthage](https://github.com/Carthage/Carthage) compatible. To include it add the following line to your `Cartfile`

```bash
github "tforzaglia/WikiView" ~> 1.0
```
Then run
```bash
carthage update
```
And drag the following frameworks into the `Link Frameworks and Libraries` section of your app's target
```
WikiView.framework
Alamofire.framework
SwiftyJSON.framework
```

## Example Usage
The `WikiPageViewController` can be presented like any other `UIViewController` in you app
```swift
let wikiViewController = WikiPageViewController(withSearchTerm: "iOS")
present(wikiViewController, animated: true)
```

## Result
The presented `UIViewController` will contain the Wikipedia page's title, thumbnail image, and introductory paragraph

## To Build
### Install Carthage
```bash
brew install carthage
```

### Build dependencies
```bash
cd $repo_root_dir
carthage bootstrap
```

### Open WikiView.xcodeproj
```bash
open WikiView.xcodeproj
```
