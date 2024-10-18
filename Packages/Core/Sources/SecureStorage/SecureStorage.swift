//
//  SecureStorage.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import KeychainAccess

final public class SecureStorage {
    private let keychain = Keychain(service: "com.organization.Quantuta")
    
    public static let shared = SecureStorage()
    
    private init() {}
    
    public func set(value: String, key: SecureStorageKey) throws {
        try keychain.set(value, key: key.rawValue)
    }
    
    public func get(key: SecureStorageKey) -> String? {
        return try? keychain.get(key.rawValue)
    }
    
    public func removeAll() throws {
        try keychain.removeAll()
    }
}
