//
//  NSObject.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

extension NSObject {
    public static var identifier: String {
        return String(describing: self)
    }
}
