//
//  ExpenseTableViewCell.swift
//  expense management
//
//  Created by Jonatas Alves santos on 20/06/22.
//

import UIKit


class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    func config(with expense: Expense) {
        itemName.text = expense.name
        itemPrice.text = expense.price.toPriceLabel(.dolar)
        itemImage.image = expense.image?.toUIImage()
    }
}
