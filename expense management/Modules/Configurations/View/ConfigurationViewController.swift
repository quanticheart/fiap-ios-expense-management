//
//  ConfigurationViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityAnimator: UIActivityIndicatorView!
    
    @IBOutlet weak var dolarQuoteTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    
    private let quotePicker: UIPickerView = UIPickerView()
    private let taxPicker: UIPickerView = UIPickerView()
    private var controller: ConfigurationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = ConfigurationController()
        setUp()
        setupPickersAndTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.loadStates()
        loadSavedInfo()
    }
    
    private func setUp() {
        navigation.title = "TAB2".localize()
        //msg.text = "MSG_STATES_LIST_EMPTY".localize()
        tableView.dataSource = self
        tableView.delegate = self
        controller?.delegate = self
        
        let tap = UIGestureRecognizer(target: self, action: #selector(dismissScreen))
        tableView.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissScreen() {
        dolarQuoteTextField.resignFirstResponder()
    }
    
    private func loadSavedInfo() {
        //check UserDefaults
    }
    
    private func setupPickersAndTextField() {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(hideKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        bar.items = [flexibleSpace, reset]
        bar.sizeToFit()
        dolarQuoteTextField.inputAccessoryView = bar
        
        quotePicker.delegate = self
        quotePicker.dataSource = self
        
        dolarQuoteTextField.inputView = quotePicker
    }
    
    
}

//MARK: - UITableViewDataSource
extension ConfigurationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let name = controller?.getStateName(indexPath)
        
        cell.textLabel?.text = name
        
        return cell
        
    }
    
}

//MARK: - UITableViewDelegate
extension ConfigurationViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - ConfigurationControllerDelegate
extension ConfigurationViewController: ConfigurationControllerDelegate {
    
    func didLoadStates() {
        DispatchQueue.main.async {
            self.activityAnimator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func didLoadWithError() {
        DispatchQueue.main.async {
            self.activityAnimator.stopAnimating()
        }
    }
    
}

//MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension ConfigurationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "5.01"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dolarQuoteTextField.text = "5,01"
        dolarQuoteTextField.resignFirstResponder()
    }

}
