//
//  ControllerExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit
import CoreData

extension UIViewController {
    
    @objc
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    func removeNotificationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
}

