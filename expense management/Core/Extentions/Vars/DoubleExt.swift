//
//  DoubleExt.swift
//  Release
//
//  Created by Jonatas Alves santos on 21/06/22.
//

import Foundation

extension Double {
    
    enum CurrencyType: String {
        case dolar = "$"
        case real = "R$"
    }
    
    func toPriceLabel(_ currencyType: CurrencyType) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencyType.rawValue
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
