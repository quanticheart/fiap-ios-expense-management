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
        mainTabBar.set(title: Localization.TAB1.getLocalizedString(), at: 0)
        mainTabBar.set(title: Localization.TAB2.getLocalizedString(), at: 1)
        mainTabBar.set(title: Localization.TAB3.getLocalizedString(), at: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettingsBundleObserver()
    }
    
    deinit {
        removeNotificationObserver()
    }
}
