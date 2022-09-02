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
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.title = "TAB2".localize()
        msg.text = "MSG_STATES_LIST_EMPTY".localize()
        
        
    }
    
    @IBAction func editIR(_ sender: Any) {
        showDialog(labelOK: "BTN_LABEL_UPDATE".localize(), labelCancel: "BTN_LABEL_CANCEL".localize(), placeholder: "SEARCH_STATE_PLACEHOLDER".localize(),
                   text: "", callback: { text in
            
        })
    }
}
