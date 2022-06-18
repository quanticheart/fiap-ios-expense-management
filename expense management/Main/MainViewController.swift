//
//  MainViewController.swift
//  expense management
//
//  Created by Jonatas Alves santos on 18/06/22.
//

import UIKit

class MainViewController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTabBar.set(title: "TAB1".localize(), at: 0)
        mainTabBar.set(title: "TAB2".localize(), at: 1)
        mainTabBar.set(title: "TAB3".localize(), at: 2)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
