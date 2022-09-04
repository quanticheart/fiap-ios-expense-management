//
//  SummaryController.swift
//  Release
//
//  Created by Alan Silva on 03/09/22.
//

import Foundation
import CoreData

import UIKit
import CoreData

extension NSObject {
    var context: NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
}

final class SummaryController: NSObject {
    
    private var dataSource = [Expense]()
    
    func loadExpenses() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest) as? [Expense] ?? []
            dataSource = result
        } catch {
            print("error")
        }
    }
    
    func getNumberOfROws() -> Int {
        return dataSource.count
    }
    
    func getExpenseByIndex(_ indexPath: IndexPath) -> Expense {
        return dataSource[indexPath.row]
    }
    
}
