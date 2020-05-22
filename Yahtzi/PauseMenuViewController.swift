//
//  PauseMenuViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/30/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol PauseMenuProtocol {
    func startNewGame()
    func setInterstitial()
}

class PauseMenuViewController: UIViewController, GADInterstitialDelegate {

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var resumeGame: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    var currentScoreNum = 0
    var highScoreNum = 0
    
    var delegate: PauseMenuProtocol? = nil
    let defaults = UserDefaults.standard
    
    var interstitial: GADInterstitial!
        
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
        
        newGame.layer.cornerRadius = 25
        resumeGame.layer.cornerRadius = 25
        homeButton.layer.cornerRadius = 25
        
        currentScore.text = "Total Score: \(currentScoreNum)"
        highScore.text = "High Score: \(highScoreNum)"
        
    }
    
    // Start new game
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
    
    // Dismiss menu
    @IBAction func resumeGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
