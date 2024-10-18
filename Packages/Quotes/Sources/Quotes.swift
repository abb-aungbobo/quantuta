//
//  Quotes.swift
//
//
//  Created by Aung Bo Bo on 11/05/2024.
//

import Foundation

class QuotesBundle {}

extension Bundle {
    public static var quotes: Bundle = {
        let bundleName = "Quotes_Quotes"
        
        let candidates = [
            Bundle.main.bundleURL,
            Bundle.main.resourceURL,
            Bundle(for: QuotesBundle.self).resourceURL,
            Bundle(for: QuotesBundle.self).resourceURL?.deletingLastPathComponent(),
            Bundle(for: QuotesBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: QuotesBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        fatalError("unable to find bundle name Quotes_Quotes")
    }()
}
