//
//  RegisterExpenseViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

final class RegisterExpenseViewController: UIViewController {
    
    @IBOutlet private weak var navigation: UINavigationItem!
    @IBOutlet private weak var textFieldName: UITextField!
    @IBOutlet private weak var textFieldPrice: UIPriceTextField!
    @IBOutlet private weak var creditCardLabel: UILabel!
    @IBOutlet private weak var creditCardSwitch: UISwitch!
    @IBOutlet private weak var labelSelectState: UILabel!
    @IBOutlet private weak var btnSelectImage: UIButton!
    @IBOutlet private weak var labelInsertDescription: UILabel!
    @IBOutlet private weak var textDescription: UITextView!
    @IBOutlet private weak var image: UIImageView!
    
    var expense: Expense?
    private var selectedState: State? = nil {
        didSet {
            if selectedState == nil {
                labelSelectState.text = Localization.HINT_SELECT_STATE.getLocalizedString()
            } else {
                labelSelectState.text = selectedState?.name
            }
        }
    }
    
    private var dialogImage: DialogImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        setup()
        setupListeners()
        setGestureReconizers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
        if let _ = UIResponder.currentFirst() as? UITextView {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y = -keyboardSize.height
                }
            }
        }

    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupLocalization() {
        navigation.title = Localization.NAVIGATION_INSERT.getLocalizedString()
        textFieldName.placeholder = Localization.HINT_NAME_EXPENSE.getLocalizedString()
        textFieldPrice.placeholder = Localization.HINT_PRICE_EXPENSE.getLocalizedString()
        labelSelectState.text = Localization.HINT_SELECT_STATE.getLocalizedString()
        btnSelectImage.setTitle(Localization.HINT_SELECT_IMAGE.getLocalizedString(),for: .normal)
        labelInsertDescription?.text = Localization.HINT_LABEL_DESCRIPTION.getLocalizedString()
        creditCardLabel.text = Localization.HINT_LABEL_CREDIT.getLocalizedString()
    }
    
    private func setGestureReconizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setup() {
        dialogImage = DialogImagePicker(presentationController: self, delegate:self)

        if let expense = expense {
            textFieldName.text = expense.name
            textFieldPrice.text = expense.price.toPriceLabel(.dolar)
            creditCardSwitch.isOn = expense.isCreditCard
            labelSelectState.text = expense.state?.name
            textDescription.text = expense.desc
            image.image = expense.image?.toUIImage()
            navigation.title = Localization.NAVIGATION_UPDATE.getLocalizedString()
        }
        
        textDescription.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func insertItem(_ sender: Any) {
        
        guard let name = textFieldName.text,
              let price = textFieldPrice.text,
              let state = selectedState?.name,
              !name.isEmpty,
              !price.isEmpty,
              !state.isEmpty
        else {
            
            let title = Localization.SUMMARY_ALERT_TITLE.getLocalizedString()
            let message = Localization.SUMMARY_ALERT_MESSAGE.getLocalizedString()
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
