//
//  DetailsExpenseViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

final class DetailsExpenseViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelNmae: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelDescription: UITextView!
    
    var expense: Expense?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let expense = expense {
            labelNmae.text = expense.name
            if let usPrice = expense.price.toPriceLabel() {
                labelPrice.text = expense.isCreditCard ? usPrice + " / R$ 78,19 - (Pago com cartão de crédito)" : usPrice
            }
            labelState.text = expense.state?.name
            labelDescription.text = expense.desc
            image.image = expense.image?.toUIImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? RegisterExpenseViewController
        vc?.expense = expense
    }
}
