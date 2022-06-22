//
//  ImageExt.swift
//  Release
//
//  Created by Jonatas Alves santos on 20/06/22.
//

import Foundation
import UIKit
import CoreData

extension Data {
    
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
    
}
