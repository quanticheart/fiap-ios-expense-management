//
//  RegisterStatesTableViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

class RegisterStatesTableViewController: UITableViewController {
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var finishBeforeSelect = false
    var states: [State] = []
    var statesFiltered: [State] = []
    
    weak var delegate: StateDelegate?
    var selectedState: State? = nil {
        didSet {
            if selectedState != nil {
                delegate?.setSelected(selectedState!)
                if finishBeforeSelect {
                    back()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadStates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.title = "NAVIGATION_INSERT_STATE".localize()
        searchBar.placeholder = "SEARCH_STATE_PLACEHOLDER".localize()
        searchBar.delegate = self
        
        loadStates()
    }
    
    
    private func loadStates() {
        states = loadDatabase(with: State.self, sortBy: "name")
        statesFiltered = states
        tableView.reloadData()
    }
    
    @IBAction func addState(_ sender: Any) {
        showAlert()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if states.count == 0 {
            self.tableView.showMenssage("MSG_STATES_LIST_EMPTY".localize())
            searchBar.isHidden = true
            return 0
        } else {
            let count = statesFiltered.count
            searchBar.isHidden = false
//            self.tableView.hideMessage()
            return count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = statesFiltered[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellState", for: indexPath) as? StateTableViewCell else {
            return UITableViewCell()
        }
        
        cell.config(with: state)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = statesFiltered[indexPath.row]
        selectedState = state
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Editar") { action, view, completionHandler in
            
            let state = self.statesFiltered[indexPath.row]
            self.showAlert(for: state)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "BTN_LABEL_EXCLUDE".localize()) { action, view, completionHandler in
            let state = self.statesFiltered[indexPath.row]
            
            self.context.delete(state)
            do {
                try self.context.save()
            } catch {
            }
            self.statesFiltered.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func showAlert(for state: State? = nil){
        showDialog(labelOK: state == nil ? "NAVIGATION_INSERT".localize() : "BTN_LABEL_UPDATE".localize(), labelCancel: "BTN_LABEL_CANCEL".localize(), placeholder: "SEARCH_STATE_PLACEHOLDER".localize(), text: state?.name, callback: { text in
            let state = self.selectedState ?? State(context: self.context)
            state.name = text
            try? self.context.save()
            self.loadStates()
        })
    }
    
}

extension RegisterStatesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText will contain user input
        // in allData I have kept all data of the table
        // filteredData used to get the filtered result
        if (searchText == ""){
            statesFiltered = states
        }else{
            statesFiltered = []
            // you can do any kind of filtering here based on user input
            statesFiltered = states.filter{
                $0.name!.lowercased().contains(searchText.lowercased())
            }
            
            if statesFiltered.count == 0 {
                tableView.showMenssage("MSG_STATES_SEARCH_EMPTY".localize())
            } else {
                tableView.hideMessage()
            }
        }
        // lastly you need to update tableView using filteredData so that the filtered rows are only shown
        //As you use SVGdata for tableView, after filtering you have to put all filtered data into SVGdata before reloading the table.
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.text = ""
        //        searchdata = countries
        
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
}


protocol StateDelegate: AnyObject {
    func setSelected(_ state: State)
}
