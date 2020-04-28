//
//  MenuViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/23/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

protocol NewGameProtocol {
    func startNewGame()
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuPopUp: UIView!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    var finalScore = 0
    var highScore = 0
    
    var delegate: NewGameProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuPopUp.layer.cornerRadius = 10
        
        newGameButton.layer.cornerRadius = 20
        
        totalScoreLabel.text = "Total Score: \(finalScore)"
        highScoreLabel.text = "High Score: \(highScore)"
    }

    @IBAction func newGame(_ sender: UIButton) {
        if (self.delegate != nil) {
            delegate?.startNewGame()
            dismiss(animated: true, completion: nil)
        }
    }
    
}
