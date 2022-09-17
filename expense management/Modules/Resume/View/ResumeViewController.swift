//
//  ConfigurationViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit

final class ResumeViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var controller: SummaryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = SummaryController()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.loadExpenses()
        checkDolarExchange()
    }
    
    private func setup() {
        controller?.delegate = self
        tableView.dataSource = self
        
        titleLabel.text = Localization.SUMMARY_TITLE.getLocalizedString()
        
    }
    
    private func checkDolarExchange() {
        
        if getUserString(forKey: "currentDolarExchange") == nil {
            let alertTitle = Localization.CONFIG_ALERT_TITLE.getLocalizedString()
            let message = Localization.CONFIG_ERROR_MESSAGE.getLocalizedString()
            let alert = UIAlertController(title: alertTitle,
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                self.tabBarController?.selectedIndex = 1
            }))
            
            present(alert, animated: true)
        }
        
    }
    
}

extension ResumeViewController: SummaryControllerDelegate {
    func didLoadExpenses() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ResumeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controller?.getTitleForSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return controller?.getNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let expense = controller?.getExpenseByIndex(indexPath)
        
        cell.textLabel?.text = expense?.0
        cell.detailTextLabel?.text = expense?.1
        
        return cell
        
    }
    
}
