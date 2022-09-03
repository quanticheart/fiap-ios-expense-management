//
//  PriceTextField.swift
//  expense management
//
//  Created by Jonatas Alves santos on 01/07/22.
//

import Foundation
import UIKit

class UIPriceTextField : UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        let text = currencyInputFormatting(text: self.text!)
        self.text = text
    }
    
    // formatting text for currency textField
    private func currencyInputFormatting(text:String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = text
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, amountWithPrefix.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        var number: NSNumber!
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func setPrice(value :Double){
        
    }
}

extension UIPriceTextField {
    func price() -> Double {
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9,]", options: .caseInsensitive)
        var amountWithPrefix = regex.stringByReplacingMatches(in: self.text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.text!.count), withTemplate: "")
        
        amountWithPrefix = amountWithPrefix.replacingOccurrences(of: ",", with: ".").trim()

        let double = (amountWithPrefix as NSString).doubleValue
        return double;
    }
}
