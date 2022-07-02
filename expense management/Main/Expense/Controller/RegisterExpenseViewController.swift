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
    @IBOutlet weak var textFieldPrice: UIPriceTextField!
    @IBOutlet weak var labelSelectState: UILabel!
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var labelInsertDescription: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var btnInsert: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    var expense: Expense!
    var selectedState: State? = nil {
        didSet {
            if selectedState == nil {
                labelSelectState.text = "HINT_SELECT_STATE".localize()
            } else {
                labelSelectState.text = selectedState?.name
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
        btnSelectImage.setTitle("HINT_SELECT_IMAGE".localize(),for: .normal)
        labelInsertDescription?.text = "HINT_LABEL_DESCRIPTION".localize()
        btnInsert.setTitle("BTN_LABEL_INSERT".localize(),for: .normal)
        
        if let expense = expense {
            textFieldName.text = expense.name
            textFieldPrice.text = expense.price.toPriceLabel()
            labelSelectState.text = expense.state?.name
            textDescription.text = expense.desc
            image.image = expense.image?.toUIImage()
            navigation.title = "NAVIGATION_UPDATE".localize()
            btnInsert.setTitle("BTN_LABEL_UPDATE".localize(), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideKeyboard()
    }
    
    @IBAction func insertItem(_ sender: Any) {
        if expense == nil {
            expense = Expense(context: context)
        }
        expense?.name = textFieldName.text
        expense?.price = textFieldPrice.price()
        expense?.state = selectedState
        expense?.image = self.image.image?.jpegData(compressionQuality: 0.8)
        expense?.desc = textDescription.text
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        dialogImage?.present()
    }
    
    func didSelect(image: UIImage?) {
        if let img = image{
            self.image.image = img
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stateVC = segue.destination as? RegisterStatesTableViewController
        stateVC?.delegate = self
        stateVC?.finishBeforeSelect = true
        stateVC?.selectedState = selectedState
    }
}

extension RegisterExpenseViewController: StateDelegate {
    func setSelected(_ state: State) {
        selectedState = state
    }
}
