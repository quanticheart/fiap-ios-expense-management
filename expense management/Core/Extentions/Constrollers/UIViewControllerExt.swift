//
//  ControllerExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

