//
//  ConfigurationViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit

final class ResumeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var controller: SummaryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = SummaryController()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.loadExpenses()
    }
    
    private func setup() {
        controller?.delegate = self
        tableView.dataSource = self
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
        
        if let real = expense?.price {
            cell.textLabel?.text = ( real * 5.15).toPriceLabel(.real)
        }
        
        //cell.textLabel?.text = expense?.price.toPriceLabel(.real)
        cell.detailTextLabel?.text = expense?.price.toPriceLabel(.dolar)
        
        return cell
        
    }
    
}
