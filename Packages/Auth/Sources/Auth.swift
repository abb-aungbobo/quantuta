//
//  Auth.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Foundation

class AuthBundle {}

extension Bundle {
    public static var auth: Bundle = {
        let bundleName = "Auth_Auth"
        
        let candidates = [
            Bundle.main.bundleURL,
            Bundle.main.resourceURL,
            Bundle(for: AuthBundle.self).resourceURL,
            Bundle(for: AuthBundle.self).resourceURL?.deletingLastPathComponent(),
            Bundle(for: AuthBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: AuthBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        fatalError("unable to find bundle name Auth_Auth")
    }()
}
