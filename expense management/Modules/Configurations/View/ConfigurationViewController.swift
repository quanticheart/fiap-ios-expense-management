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
    
    @IBOutlet weak var errorQuoteLabel: UILabel!
    @IBOutlet weak var errorTaxlabel: UILabel!
    
    private var controller: ConfigurationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = ConfigurationController()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.loadStates()
    }
    
    private func setUp() {
        navigation.title = "TAB2".localize()
        //msg.text = "MSG_STATES_LIST_EMPTY".localize()
        tableView.dataSource = self
        tableView.delegate = self
        controller?.delegate = self
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
