//
//  RegisterExpenseViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

class RegisterExpenseViewController: UIViewController, ImagePickerDelegate{
 
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var labelSelectState: UILabel!
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var btnInsert: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    var expense: Expense!
    var selectedCategories: State? = nil {
        didSet {
            if selectedCategories == nil {
                labelSelectState.text = "HINT_SELECT_STATE".localize()
            } else {
                labelSelectState.text = selectedCategories?.name
            }
        }
    }
    
    private var dialogImage: DialogImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogImage = DialogImagePicker(presentationController:self, delegate:self)
        
        navigation.title = "NAVIGATION_INSERT".localize()
        textFieldName.placeholder = "HINT_NAME_EXPENSE".localize()
        textFieldPrice.placeholder = "HINT_PRICE_EXPENSE".localize()
        labelSelectState.text = "HINT_SELECT_STATE".localize()
        btnSelectImage.titleLabel?.text = "HINT_SELECT_IMAGE".localize()
        btnInsert.titleLabel?.text = "BTN_LABEL_INSERT".localize()
        
        if let expense = expense {
            textFieldName.text = expense.name
            textFieldName.text = "\(expense.price)"
            labelSelectState.text = expense.states?.name
            image.image = expense.image?.toUIImage()
            btnInsert.setTitle("BTN_LABEL_UPDATE".localize(), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideKeyboard()
    }
    
    @IBAction func insertItem(_ sender: Any) {
    }
    
    @IBAction func selectImage(_ sender: Any) {
        dialogImage?.present()
    }
    
    func didSelect(image: UIImage?) {
        if let img = image{
            self.image.image = img
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
