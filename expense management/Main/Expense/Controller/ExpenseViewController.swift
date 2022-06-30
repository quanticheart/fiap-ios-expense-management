//
//  ExpenseViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit
import CoreData

class ExpenseViewController: UITableViewController {
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Expense> = {
        return coreDataController(with: Expense.self, sortBy: "name", delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = UITableView.automaticDimension
        navigation.title = "TAB1".localize()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let detailsViewController = segue.destination as? DetailsExpenseViewController else { return }
        
        let expense = fetchedResultsController.object(at: indexPath)
        detailsViewController.expense = expense
    }
    
    private func loadMovies() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        if count == 0 {
            self.tableView.showMenssage("MSG_EXPENSE_LIST_EMPTY".localize())
        } else {
            self.tableView.hideMessage()
            
        }
        return count
    }
    
    // UITableViewAutomaticDimension calculates height of label contents/text
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellExpense", for: indexPath) as? ExpenseTableViewCell
        
        let expense = fetchedResultsController.object(at: indexPath)
        cell!.config(with: expense)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = fetchedResultsController.object(at: indexPath)
            context.delete(movie)
            try? context.save()
        }
    }
    
}

extension ExpenseViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
