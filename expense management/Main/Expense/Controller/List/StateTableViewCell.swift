//
//  StateTableViewCell.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import UIKit

class StateTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    func config(with state: State) {
        itemName.text = state.name
    }
}
