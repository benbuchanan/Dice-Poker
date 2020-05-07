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
    @IBOutlet weak var homeButton: UIButton!
    
    var finalScore = 0
    var highScore = 0
    
    var delegate: NewGameProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuPopUp.layer.cornerRadius = 20
        menuPopUp.layer.shadowColor = UIColor.black.cgColor
        menuPopUp.layer.shadowOffset = .zero
        menuPopUp.layer.shadowOpacity = 0.25
        menuPopUp.layer.shadowRadius = 30
        
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOffset = .zero
        homeButton.layer.shadowOpacity = 0.15
        homeButton.layer.shadowRadius = 7.5
        
        newGameButton.layer.cornerRadius = 20
        homeButton.layer.cornerRadius = 20
        
        totalScoreLabel.text = "Total Score: \(finalScore)"
        highScoreLabel.text = "High Score: \(highScore)"
    }

    // start a new game
    @IBAction func newGame(_ sender: UIButton) {
        if (self.delegate != nil) {
            delegate?.startNewGame()
            dismiss(animated: true, completion: nil)
        }
    }
    
}
