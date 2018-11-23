////
////  TestTest.swift
////  WorldWide
////
////  Created by Hoang Trong Anh on 11/22/18.
////  Copyright © 2018 Hoang Trong Anh. All rights reserved.
////
import Foundation
import UIKit

public protocol UserDefaultKey: RawRepresentable, CustomStringConvertible { }

public extension UserDefaultKey where RawValue == String {
    public var description: String {
        return self.rawValue
    }
}

enum DefaultKeys: String, UserDefaultKey {
    case WW_SESSION_USER_TOKEN
    case WW_SESSION_USER_TTL
    case WW_SESSION_USER_UID
}

// MARK: getter
public extension UserDefaults {
    public func object<Key: UserDefaultKey>(forKey key: Key) -> Any? {
        return object(forKey: key.description)
    }

    public func url<Key: UserDefaultKey>(forKey key: Key) -> URL? {
        return url(forKey: key.description)
    }

    public func array<Key: UserDefaultKey>(forKey key: Key) -> [Any]? {
        return array(forKey: key.description)
    }

    public func dictionary<Key: UserDefaultKey>(forKey key: Key) -> [String: Any]? {
        return dictionary(forKey: key.description)
    }

    public func string<Key: UserDefaultKey>(forKey key: Key) -> String? {
        return string(forKey: key.description)
    }

    public func stringArray<Key: UserDefaultKey>(forKey key: Key) -> [String]? {
        return stringArray(forKey: key.description)
    }

    public func data<Key: UserDefaultKey>(forKey key: Key) -> Data? {
        return data(forKey: key.description)
    }

    public func bool<Key: UserDefaultKey>(forKey key: Key) -> Bool? {
        return bool(forKey: key.description)
    }

    public func integer<Key: UserDefaultKey>(forKey key: Key) -> Int? {
        return integer(forKey: key.description)
    }

    public func float<Key: UserDefaultKey>(forKey key: Key) -> Float? {
        return float(forKey: key.description)
    }

    public func double<Key: UserDefaultKey>(forKey key: Key) -> Double? {
        return double(forKey: key.description)
    }
}

// MARK: - setter
public extension UserDefaults {
    public func set<Key: UserDefaultKey>(_ value: Any?, forKey key: Key) {
        set(value, forKey: key.description)
    }
    
    public func set<Key: UserDefaultKey>(_ value: String?, forKey key: Key) {
        set(value, forKey: key.description)
    }

    public func set<Key: UserDefaultKey>(_ value: URL?, forKey key: Key) {
        set(value, forKey: key.description)
    }

    public func set<Key: UserDefaultKey>(_ value: Bool, forKey key: Key) {
        set(value, forKey: key.description)
    }

    public func set<Key: UserDefaultKey>(_ value: Int, forKey key: Key) {
        set(value, forKey: key.description)
    }

    public func set<Key: UserDefaultKey>(_ value: Float, forKey key: Key) {
        set(value, forKey: key.description)
    }

    public func set<Key: UserDefaultKey>(_ value: Double, forKey key: Key) {
        set(value, forKey: key.description)
    }
}

protocol UserDefaultsDataStore {
    var WW_SESSION_USER_TOKEN: String? { get set }
    var WW_SESSION_USER_TTL: Int? { get set }
    var WW_SESSION_USER_UID: Int? { get set }
}

fileprivate enum UserDefaultsDataStoreKeys: String, UserDefaultKey {
    case WW_SESSION_USER_TOKEN
    case WW_SESSION_USER_TTL
    case WW_SESSION_USER_UID
}

struct UserDefaultsDataStoreImpl: UserDefaultsDataStore {
    var WW_SESSION_USER_TOKEN: String? {
        get {
            return string(forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_TOKEN) ?? nil
        }
        
        set {
            set(value: newValue, forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_TOKEN)
        }
    }
    
    var WW_SESSION_USER_TTL: Int? {
        get {
            return integer(forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_TTL) ?? nil
        }
        
        set {
            set(value: newValue, forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_TTL)
        }
    }
    
    var WW_SESSION_USER_UID: Int? {
        get {
            return integer(forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_UID) ?? nil
        }
        
        set {
            set(value: newValue, forKey: UserDefaultsDataStoreKeys.WW_SESSION_USER_UID)
        }
    }
    

    private var defaults: UserDefaults {
        return UserDefaults.standard
    }
}

private extension UserDefaultsDataStoreImpl {
    func object(forKey key: UserDefaultsDataStoreKeys) -> Any? {
        return defaults.object(forKey: key)
    }

    func url(forKey key: UserDefaultsDataStoreKeys) ->URL? {
        return defaults.url(forKey: key)
    }

    func array(forKey key: UserDefaultsDataStoreKeys) ->[Any]? {
        return defaults.array(forKey: key)
    }

    func dictionary(forKey key: UserDefaultsDataStoreKeys) ->[String: Any]? {
        return defaults.dictionary(forKey: key)
    }

    func string(forKey key: UserDefaultsDataStoreKeys) ->String? {
        return defaults.string(forKey: key)
    }

    func stringArray(forKey key: UserDefaultsDataStoreKeys) ->[String]? {
        return defaults.stringArray(forKey: key)
    }

    func data(forKey key: UserDefaultsDataStoreKeys) ->Data? {
        return defaults.data(forKey: key)
    }

    func bool(forKey key: UserDefaultsDataStoreKeys) ->Bool? {
        return defaults.bool(forKey: key)
    }

    func integer(forKey key: UserDefaultsDataStoreKeys) ->Int? {
        return defaults.integer(forKey: key)
    }

    func float(forKey key: UserDefaultsDataStoreKeys) ->Float? {
        return defaults.float(forKey: key)
    }

    func double(forKey key: UserDefaultsDataStoreKeys) ->Double? {
        return defaults.double(forKey: key)
    }

    func set<V>(value: V?, forKey key: UserDefaultsDataStoreKeys) {
        if let v = value {
            defaults.set(v, forKey: key)
            defaults.synchronize()
        }
    }
}
