//
//  NSObjetc+Ext.swift
//  Release
//
//  Created by U010616 on 04/09/22.
//

import UIKit
import CoreData

extension NSObject {
    var context: NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
}
