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
        setUserString(forKey: SettingsBundleKeys.AppVersionKey, value: version)
        
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        setUserString(forKey: SettingsBundleKeys.BuildVersionKey, value: build)
    }
    
    class func setVlues() {
        let dolar = getUserString(forKey: SettingsBundleKeys.Dolar) ?? "5.00"
        setUserString(forKey: SettingsBundleKeys.Dolar, value: dolar)

        let ir = getUserString(forKey: SettingsBundleKeys.Dolar) ?? "6"
        setUserString(forKey: SettingsBundleKeys.Ir, value: ir)
    }
}

extension UIViewController {
    func registerSettingsBundleObserver() {
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        notificationObserver()
        changeTheme()
    }
    
    @objc func changeTheme() {
        if getUserBoolean(forKey: SettingsBundleHelper.SettingsBundleKeys.darkModeKey) {
            self.overrideUserInterfaceStyle = .dark
        } else {
            self.overrideUserInterfaceStyle = .light
        }
    }
    
    func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTheme), name: UserDefaults.didChangeNotification, object: nil)
    }
    
}
