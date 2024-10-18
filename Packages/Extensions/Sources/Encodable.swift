//
//  Encodable.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

extension Encodable {
    public var dictionary: [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary ?? [:]
        } catch {
            return [:]
        }
    }
}
