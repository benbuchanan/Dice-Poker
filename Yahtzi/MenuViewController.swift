//
//  MenuViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/23/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol NewGameProtocol {
    func startNewGame()
    func setInterstitial()
}

class MenuViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var menuPopUp: UIView!
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    var finalScore = 0
    var highScore = 0
    
    var delegate: NewGameProtocol? = nil
    let defaults = UserDefaults.standard
    
    var interstitial: GADInterstitial!
    
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
        
        newGameButton.layer.cornerRadius = 25
        homeButton.layer.cornerRadius = 25
        
        totalScoreLabel.text = "Total Score: \(finalScore)"
        highScoreLabel.text = "High Score: \(highScore)"
    }

    // start a new game
    @IBAction func newGame(_ sender: UIButton) {
        if (self.delegate != nil) {
            delegate?.startNewGame()
            
            if (!defaults.bool(forKey: "purchased") && defaults.integer(forKey: "game_count") >= 5) {
                self.displayInterstitial()
            } else {
                dismiss(animated: true, completion: nil)
            }
            
            delegate?.setInterstitial()
        }
    }
    
    // MARK: - Interstitial ad functions
    func displayInterstitial() {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
            defaults.set(0, forKey: "game_count")
        } else {
          print("Ad wasn't ready")
            dismiss(animated: true, completion: nil)
        }
    }
    
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
