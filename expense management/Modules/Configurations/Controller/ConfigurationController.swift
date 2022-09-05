//
//  ConfigurationController.swift
//  Release
//
//  Created by Alan Silva on 04/09/22.
//

import UIKit
import CoreData

protocol ConfigurationControllerDelegate: AnyObject {
    func didLoadStates()
    func didLoadWithError()
}

final class ConfigurationController: NSObject {
    
    private var states = [State]()
    private var quoteValues = [Double]()
    
    weak var delegate: ConfigurationControllerDelegate?
    
    override init() {
        super.init()
        generateQuoteValues()
    }
    
    func loadStates() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "State")
        
        do {
            let result = try context.fetch(fetchRequest) as? [State] ?? []
            states = result
            delegate?.didLoadStates()
        } catch {
            delegate?.didLoadWithError()
        }
    }
    
    func getNumberOfRows() -> Int {
        return states.count
    }
    
    func getStateName(_ indexPath: IndexPath) -> String {
        return states[indexPath.row].name ?? ""
    }
    
    private func generateQuoteValues() {}
    
    func titleForPickerRow(row: Int) -> String {
        quoteValues[row].toPriceLabel(.real) ?? ""
    }
    
    func numberOfRowsInComponent() -> Int {
        return quoteValues.count
    }
    
}
