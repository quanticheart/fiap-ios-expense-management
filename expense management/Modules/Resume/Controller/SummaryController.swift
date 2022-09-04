//
//  SummaryController.swift
//  Release
//
//  Created by Alan Silva on 03/09/22.
//

import UIKit
import CoreData

protocol SummaryControllerDelegate: AnyObject {
    func didLoadExpenses()
}

final class SummaryController: NSObject {
    
    private var dataSource = [Expense]()
    
    private var creditCardExpenses: [Expense] {
        self.dataSource.filter { $0.isCreditCard }
    }
    
    private var otherExpenses: [Expense] {
        self.dataSource.filter { !$0.isCreditCard }
    }
    
    weak var delegate: SummaryControllerDelegate?
    
    func loadExpenses() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        
        do {
            let result = try context.fetch(fetchRequest) as? [Expense] ?? []
            dataSource = result
            delegate?.didLoadExpenses()
        } catch {
            print("error")
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getTitleForSection(_ section: Int) -> String {
        switch section {
        case 0:
            return "Despesas com cartão de crédito"
        case 1:
            return "Despesas com outros métodos"
        default:
            return ""
        }
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        
        switch section {
        case 0:
            return creditCardExpenses.count
        case 1:
            return otherExpenses.count
        default:
            return 0
        }
        
        //return dataSource.count
    }
    
    func getExpenseByIndex(_ indexPath: IndexPath) -> Expense {
        
        if indexPath.section == 0 {
            return creditCardExpenses[indexPath.row]
        } else {
            return otherExpenses[indexPath.row]
        }
        
        //        let creditCardExpenses = dataSource.filter { $0.isCreditCard }
        //        let otherExpenses = dataSource.filter { !$0.isCreditCard }
        
        //return dataSource[indexPath.row]
    }
    
}
