//
//  DoubleExt.swift
//  Release
//
//  Created by Jonatas Alves santos on 21/06/22.
//

import Foundation

extension Double {
    
    func toPriceLabel() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: self as NSNumber)!
    }
    
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
}
