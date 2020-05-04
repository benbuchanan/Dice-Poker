//
//  PauseMenuViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/30/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

protocol PauseMenuProtocol {
    func startNewGame()
}

class PauseMenuViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var resumeGame: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    var currentScoreNum = 0
    var highScoreNum = 0
    
    var delegate: PauseMenuProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.layer.cornerRadius = 20
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOffset = .zero
        menuView.layer.shadowOpacity = 0.25
        menuView.layer.shadowRadius = 30
        
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOffset = .zero
        homeButton.layer.shadowOpacity = 0.15
        homeButton.layer.shadowRadius = 7.5
        
        newGame.layer.cornerRadius = 17.5
        resumeGame.layer.cornerRadius = 17.5
        homeButton.layer.cornerRadius = 17.5
        
        currentScore.text = "Total Score: \(currentScoreNum)"
        highScore.text = "High Score: \(highScoreNum)"
        
    }
    
    // Start new game
    @IBAction func newGame(_ sender: UIButton) {
        if (self.delegate != nil) {
            delegate?.startNewGame()
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Dismiss menu
    @IBAction func resumeGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
