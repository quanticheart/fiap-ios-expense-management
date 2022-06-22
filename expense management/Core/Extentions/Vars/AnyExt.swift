//
//  AnyExt.swift
//  Release
//
//  Created by Jonatas Alves santos on 21/06/22.
//

import Foundation

extension Hashable where Self: AnyObject {
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
