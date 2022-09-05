# SDL

[![CI Status](https://img.shields.io/travis/MrTrent/SDL.svg?style=flat)](https://travis-ci.org/MrTrent/SDL)
[![Version](https://img.shields.io/cocoapods/v/SDL.svg?style=flat)](https://cocoapods.org/pods/SDL)
[![License](https://img.shields.io/cocoapods/l/SDL.svg?style=flat)](https://cocoapods.org/pods/SDL)
[![Platform](https://img.shields.io/cocoapods/p/SDL.svg?style=flat)](https://cocoapods.org/pods/SDL)

## Info

SDL - segue data layer. It's small and useful lib to pass data by string key as url for example.
It's base for another pod - 'Router'.

## Example

You can check example in pod, but lets look on base things.    
SDL is very simple.     

```swift
import SDL

// create example data
let data = SomeData(name: "Noname", age: 0)
// pass data to SDL
let key = SDL.shared.set(data)
// then we can create some sort of in-app url with query item stored data key
let url = URL(string: "/vc2?data=\(key)")!
// .....
// Later we can get data by key
let data = SDL.shared.get(for: key, expectedType: SomeData.self)
```    

## SDL protocol reference
```swift
public protocol SDL_Protocol {
    /// try get data - Data will be removed after return by default 
    func get<T>(for key: String, expectedType: T.Type) -> T?
    
    /// try get data - Data will be removed after return by default 
    func get(for key: String) -> Any?
    
    /// try to get data with expected type - doesn't removes data from storage. Don't forget to clear data.
    func getRetain<T>(for key: String, expectedType: T.Type) -> T?
    
    /// try get data for key - doesn't removes data from storage. Don't forget to clear data.
    func getRetain(for key: String) -> Any?
        
    /// put data to share. Returns string key to access.
    func set(_ data: Any) -> String
    
    /// remove data for key
    func remove(for key: String)
}
```

## Requirements

:small_blue_diamond: swift 5 :small_blue_diamond: ios 13.0 :small_blue_diamond:

## Installation

SDL is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDL'
```

## Author

MrTrent, show6time@gmail.com

## License

SDL is available under the MIT license. See the LICENSE file for more info.
