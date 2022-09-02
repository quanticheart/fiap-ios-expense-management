//
//  SettingsBundleHelper.swift
//  expense management
//
//  Created by Jonatas Alves santos on 02/07/22.
//

import Foundation
import UIKit

class SettingsBundleHelper {
    
    struct SettingsBundleKeys {
        static let Reset = "RESET_APP_KEY"
        static let Dolar = "DOLAR"
        static let Ir = "IR"
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
        static let darkModeKey = "dark_preference"
    }
    
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            // reset userDefaults..
            // CoreDataDataModel().deleteAllData()
            // delete all other user data here..
        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: SettingsBundleKeys.AppVersionKey)
        
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: SettingsBundleKeys.BuildVersionKey)
    }
    
    class func setVlues() {
        let dolar = UserDefaults.standard.string(forKey: SettingsBundleKeys.Dolar)
        UserDefaults.standard.set("5.00", forKey: SettingsBundleKeys.Dolar)
        
        UserDefaults.standard.set("6", forKey: SettingsBundleKeys.Ir)
    }
}

extension UIViewController {
    func registerSettingsBundleObserver() {
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        notificationObserver()
        defaultsChanged()
    }
    
    @objc func defaultsChanged() {
        if UserDefaults.standard.bool(forKey: "RedThemeKey") {
            self.view.backgroundColor = UIColor.red
        } else {
            self.view.backgroundColor = UIColor.green
        }
    }
    
    func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
    }
    
}
