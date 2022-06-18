//
//  TabBarExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 18/06/22.
//

import Foundation
import UIKit

extension UITabBar {
    func set(title value:String, at pos:Int){
        self.items![pos].title = value
    }
}
