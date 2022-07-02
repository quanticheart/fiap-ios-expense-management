//
//  ConfigurationViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 19/06/22.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var msg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.title = "TAB2".localize()
        msg.text = "MSG_STATES_LIST_EMPTY".localize()
        
        
    }
}
