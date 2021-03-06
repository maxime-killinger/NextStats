//
//  Extensions.swift
//  NextStats
//
//  Created by Jon Alaniz on 2/15/20.
//  Copyright © 2020 Jon Alaniz. All rights reserved.
//

import UIKit
import WebKit

extension Notification.Name {
    static let serverDidChange = Notification.Name("serversDidChange")
    static let authenticationCanceled = Notification.Name("authenticationCanceled")
}

extension String {
    // Add https
    func addDomainPrefix() -> String {
        if self.hasPrefix("http://") {
            return "https://" + self
        } else if self.hasPrefix("https://") {
            return self
        } else {
            return "https://" + self
        }
    }
    
    func addIPPrefix() -> String {
        if self.hasPrefix("http://") {
            return self
        } else {
            return "http://" + self
        }
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    // Remove https://
    func makeFriendlyURL() -> String {
        if self.hasPrefix("https://") {
            return self.replacingOccurrences(of: "https://", with: "")
        } else {
            return self.replacingOccurrences(of: "http://", with: "")
        }
        
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

extension UIActivityIndicatorView {
    func activate() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func deactivate() {
        self.isHidden = true
        self.stopAnimating()
    }
}

extension WKWebView {
    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}
