//
//  MainViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 18/06/22.
//

import UIKit

class MainViewController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidAppear(_ animated: Bool) {
        mainTabBar.set(title: "TAB1".localize(), at: 0)
        mainTabBar.set(title: "TAB2".localize(), at: 1)
        mainTabBar.set(title: "TAB3".localize(), at: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettingsBundleObserver()
    }
    
    deinit {
        removeNotificationObserver()
    }
}
