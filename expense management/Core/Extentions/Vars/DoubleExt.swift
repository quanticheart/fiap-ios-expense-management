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
        do{
            return try Double(self) ?? 0.0
        } catch {
            return 0.0
        }
    }
    
}
