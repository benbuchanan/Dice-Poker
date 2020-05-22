//
//  LaunchScreenViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/22/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconImage.layer.cornerRadius = 20
        iconImage.layer.shadowColor = UIColor.black.cgColor
        iconImage.layer.shadowOffset = .init(width: 0, height: 5)
        iconImage.layer.shadowOpacity = 0.35
        iconImage.layer.shadowRadius = 7
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
