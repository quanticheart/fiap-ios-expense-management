//
//  DialogExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 24/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showDialog(labelOK:String, labelCancel:String, placeholder:String, text:String?, callback : @escaping (String)-> Void) {
        let alert = UIAlertController(title: labelOK, message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = text
        }
        
        let okAction = UIAlertAction(title: labelOK, style: .default) { _ in
            let text = alert.textFields?.first?.text
            if text != nil {
                callback(text!)
            }
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: labelCancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
