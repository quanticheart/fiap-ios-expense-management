//
//  StringExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 18/06/22.
//

import Foundation
import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getColor() -> UIColor? {
        return UIColor(named: self)
    }
}
