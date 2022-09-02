//
//  UserDefaultsExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 01/09/22.
//

import Foundation

func getUserString(forKey: String) -> String? {
    return UserDefaults.standard.string(forKey: forKey)
}

func setUserString(forKey: String, value:String?) {
     UserDefaults.standard.set(value, forKey: forKey)
}

func getUserBoolean(forKey: String) -> Bool {
     return UserDefaults.standard.bool(forKey: forKey)
}

func setUserBoolean(forKey: String, value:Bool?) {
     UserDefaults.standard.set(value ?? false, forKey: forKey)
}
