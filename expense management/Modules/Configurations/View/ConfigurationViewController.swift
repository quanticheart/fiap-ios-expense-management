//
//  ConfigurationViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    
    @IBOutlet private weak var navigation: UINavigationItem!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var todaysExchangeLabel: UILabel!
    @IBOutlet private weak var taxExchangeLabel: UILabel!
    @IBOutlet private weak var activityAnimator: UIActivityIndicatorView!
    @IBOutlet private weak var dolarQuoteTextField: UITextField!
    @IBOutlet private weak var taxTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var stateListTitle: UILabel!
    
    private var controller: ConfigurationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = ConfigurationController()
        setUp()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.loadStates()
        loadSavedInfo()
    }
    
    private func setUp() {
        navigation.title = Localization.TAB2.getLocalizedString()
        todaysExchangeLabel.text = Localization.TODAYS_EXCHANGE.getLocalizedString()
        taxExchangeLabel.text = Localization.IOF_TAX.getLocalizedString()
        saveButton.setTitle(Localization.SAVE_BUTTON_TITLE.getLocalizedString(), for: .normal)
        stateListTitle.text = Localization.STATES_LIST.getLocalizedString()
        
        tableView.dataSource = self
        tableView.delegate = self
        controller?.delegate = self
    }
    
    @objc func dismissScreen() {
        dolarQuoteTextField.resignFirstResponder()
    }
    
    private func loadSavedInfo() {
        let saved = getUserString(forKey: "currentDolarExchange")
        dolarQuoteTextField.text = saved
    }
    
    private func setupTextField() {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(hideKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        bar.items = [flexibleSpace, reset]
        bar.sizeToFit()
        dolarQuoteTextField.inputAccessoryView = bar
        dolarQuoteTextField.keyboardType = .numbersAndPunctuation
    }
    
    private func showAlertSaveMessage() {
        let alertTitle = Localization.CONFIG_ALERT_TITLE.getLocalizedString()
        let message = Localization.CONFIG_ALERT_MESSAGE.getLocalizedString()
        let alert = UIAlertController(title: alertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func didTapSave(_ sender: UIButton) {
        
        guard let value = dolarQuoteTextField.text else {
            return
        }
        
        setUserString(forKey: "currentDolarExchange", value: value)
        
        if let double = (value as? NSString)?.doubleValue {
            setUserDouble(forKey: "currentDoubleDolarExchange", value: double)
        }
        DispatchQueue.main.async { [weak self] in
            self?.showAlertSaveMessage()
        }
        
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
