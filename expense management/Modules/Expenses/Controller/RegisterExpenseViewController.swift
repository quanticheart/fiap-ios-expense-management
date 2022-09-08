//
//  RegisterExpenseViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

final class RegisterExpenseViewController: UIViewController {
    
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UIPriceTextField!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var creditCardSwitch: UISwitch!
    @IBOutlet weak var labelSelectState: UILabel!
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var labelInsertDescription: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var btnInsert: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    
    var expense: Expense?
    private var selectedState: State? = nil {
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
        setupLocalization()
        setupFields()
        setFields()
    }
    
    private func setupFields() {
        textFieldPrice.keyboardType = .numberPad
        let tap = UIGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupLocalization() {
        dialogImage = DialogImagePicker(presentationController: self, delegate:self)
        
        navigation.title = "NAVIGATION_INSERT".localize()
        textFieldName.placeholder = "HINT_NAME_EXPENSE".localize()
        textFieldPrice.placeholder = "HINT_PRICE_EXPENSE".localize()
        labelSelectState.text = "HINT_SELECT_STATE".localize()
        btnSelectImage.setTitle("HINT_SELECT_IMAGE".localize(),for: .normal)
        labelInsertDescription?.text = "HINT_LABEL_DESCRIPTION".localize()
        btnInsert.setTitle("BTN_LABEL_INSERT".localize(),for: .normal)
    }
    
    private func setFields() {
        if let expense = expense {
            textFieldName.text = expense.name
            textFieldPrice.text = expense.price.toPriceLabel(.dolar)
            creditCardSwitch.isOn = expense.isCreditCard
            labelSelectState.text = expense.state?.name
            textDescription.text = expense.desc
            image.image = expense.image?.toUIImage()
            navigation.title = "NAVIGATION_UPDATE".localize()
            btnInsert.setTitle("BTN_LABEL_UPDATE".localize(), for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideKeyboard()
    }
    
    @IBAction func insertItem(_ sender: Any) {
        
        guard let name = textFieldName.text,
              let price = textFieldPrice.text,
              let state = selectedState?.name,
              !name.isEmpty,
              !price.isEmpty,
              !state.isEmpty
        else {
            
            let title = "SUMMARY_ALERT_TITLE".localize()
            let message = "SUMMARY_ALERT_MESSAGE".localize()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
            return
        }
        
        if expense == nil {
            expense = Expense(context: context)
        }
        expense?.name = textFieldName.text
        expense?.price = textFieldPrice.price()
        expense?.isCreditCard = creditCardSwitch.isOn
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
    
    //MARK: - Actions
    @IBAction func selectImage(_ sender: Any) {
        dialogImage?.present()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stateVC = segue.destination as? RegisterStatesTableViewController
        stateVC?.delegate = self
        stateVC?.finishBeforeSelect = true
        stateVC?.selectedState = selectedState
    }
}

// MARK: - ImagePickerDelegate
extension RegisterExpenseViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let img = image{
            self.image.image = img
        }
    }
    
}

// MARK: - StateDelegate
extension RegisterExpenseViewController: StateDelegate {
    func setSelected(_ state: State) {
        selectedState = state
    }
}
