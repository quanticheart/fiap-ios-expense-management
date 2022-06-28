//
//  DoubleExt.swift
//  Release
//
//  Created by Jonatas Alves santos on 21/06/22.
//

import Foundation

extension Double {
    
    func toPriceLabel() -> String? {
        return String(format: "%.1f",self)
    }
    
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
}
