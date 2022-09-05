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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        
        let complementaryString = "Pago com cartão de crédito"
        
        if let expense = expense {
            labelNmae.text = expense.name
            if let usPrice = expense.price.toPriceLabel(.dolar) {
                let value = getUserDouble(forKey: "currentDoubleDolarExchange")
                let realPrice = expense.price * value
                let real = realPrice.toPriceLabel(.real)
                labelPrice.text = expense.isCreditCard ? usPrice + " / \(real ?? "") - (\(complementaryString))" : usPrice
            }
            labelState.text = expense.state?.name
            labelDescription.text = expense.desc
            image.image = expense.image?.toUIImage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? RegisterExpenseViewController
        vc?.expense = expense
    }
}
