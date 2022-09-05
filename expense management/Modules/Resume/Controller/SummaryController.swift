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
    
    private let iof = 0.0638
    private var cambio = 0.0
    
    private var creditCardExpenses: Double {
        self.dataSource.filter { $0.isCreditCard }.map { $0.price }.reduce(0, +)
    }
    
    private var otherExpenses: Double {
        self.dataSource.filter { !$0.isCreditCard }.map { $0.price }.reduce(0, +)
    }
    
    weak var delegate: SummaryControllerDelegate?
    
    private func loadSavedInfo() {
        let value = getUserDouble(forKey: "currentDoubleDolarExchange")
        cambio = value
    }
    
    func loadExpenses() {
        
        loadSavedInfo()
        
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
        return 1
    }
    
    func getExpenseByIndex(_ indexPath: IndexPath) -> (String, String) {
        
        if indexPath.section == 0 {
            
            let tax = creditCardExpenses * iof
            
            guard let real = ((creditCardExpenses + tax) * cambio).toPriceLabel(.real),
                  let dolar = creditCardExpenses.toPriceLabel(.dolar) else {
                return ("", "")
            }
            
            return (real, dolar + " x \(cambio.toPriceLabel(.real) ?? "") + IOF(6,38%)")
        } else {
            
            guard let real = (otherExpenses * cambio).toPriceLabel(.real),
                  let dolar = otherExpenses.toPriceLabel(.dolar) else {
                return ("", "")
            }
            
            return (real, dolar)
        }
        
    }
    
}
