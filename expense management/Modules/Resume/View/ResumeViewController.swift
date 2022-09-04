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
        controller?.loadExpenses()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        tableView.dataSource = self
    }
    
}

extension ResumeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.getNumberOfROws() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let expense = controller?.getExpenseByIndex(indexPath)
        
        cell.detailTextLabel?.text = expense?.name
        cell.textLabel?.text = expense?.price.toPriceLabel()
        
        return cell
        
    }
    
}
