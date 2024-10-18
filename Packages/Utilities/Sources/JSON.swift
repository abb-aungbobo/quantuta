//
//  JSON.swift
//  
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

public enum JSON {
    public static func decode<T: Codable>(from file: String, bundle: Bundle) throws -> T {
        guard let url = bundle.url(forResource: file, withExtension: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
