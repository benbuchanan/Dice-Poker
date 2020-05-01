//
//  HomeScreenViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 5/1/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGameButton.layer.cornerRadius = 22.5
        
    }
    


}
