//
//  Module: SDL
//  Created by: MrTrent on 03.09.2022
//  Copyright (c) 2022 Zordz Union
//  


import Foundation
import ZUCore

public protocol SDL_Protocol {
    /// try get data - By default data will be removed after return
    func get<T>(for key: String, expectedType: T.Type) -> T?
    
    /// try get data - By default data will be removed after return
    func get(for key: String) -> Any?
    
    /// try to get data with expected type - don't removes data from storage. Don't forget to clear data.
    func getRetain<T>(for key: String, expectedType: T.Type) -> T?
    
    /// try get data for key - don't removes data from storage. Don't forget to clear data.
    func getRetain(for key: String) -> Any?
        
    /// put data to share. Returns string key to access.
    func set(_ data: Any) -> String
    
    /// remove data for key
    func remove(for key: String)
}

public class SDL: SDL_Protocol {
    /// global instance
    public static let shared: SDL_Protocol = SDL()
    
    /// data storage to share
    private var sharedData: [String: Any] = [:]
    
    /// try get data and then remove anyway from layer - preffered way to use
    public func get<T>(for key: String, expectedType: T.Type) -> T? {
        return sharedData.removeValue(forKey: key) as? T
    }
    
    /// try get data and then remove anyway from layer - preffered way to use
    public func get(for key: String) -> Any? {
        return sharedData.removeValue(forKey: key)
    }
    
    /// try to get data with expected type - don't removes data from storage. Don't forget to clear data.
    public func getRetain<T>(for key: String, expectedType: T.Type) -> T? {
        if let data = sharedData[key] as? T {
            return data
        }
        return nil
    }
    
    /// try get data for key - don't removes data from storage. Don't forget to clear data.
    public func getRetain(for key: String) -> Any? {
        return sharedData[key]
    }
    
    /// put data to share. Returns string key to access.
    public func set(_ data: Any) -> String {
        let key = generateKey(data)
        sharedData[key] = data
        return key
    }
    
    /// remove data for key
    public func remove(for key: String) {
        sharedData.removeValue(forKey: key)
    }
    
    /// generates string key based on data memory address, type, count.
    internal func generateKey(_ data: Any) -> String {
        let type = String(describing: data.self)
        let address = MemoryAddressUtils.getAddress(data)
        let count = sharedData.keys.count
        let key = "\(type)_\(address)_\(count)"
        return "\(key.hashValue)"
    }
}
