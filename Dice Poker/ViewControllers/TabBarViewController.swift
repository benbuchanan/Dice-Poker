//
//  TabBarViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 6/16/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var customTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch UserDefaults.standard.string(forKey: "background color") {
        case "white":
            customTabBar.barTintColor = #colorLiteral(red: 0.9411764706, green: 1, blue: 1, alpha: 1)
        case "offwhite":
            customTabBar.barTintColor = #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.8470588235, alpha: 1)
        case "dark":
            customTabBar.barTintColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        default:
            customTabBar.barTintColor = UIColor.white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Disabling rotation
    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

}
