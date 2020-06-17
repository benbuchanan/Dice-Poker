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
    
    let darkPopOut = #colorLiteral(red: 0.3137254902, green: 0.3137254902, blue: 0.3333333333, alpha: 1)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (defaults.string(forKey: "background color") == "white") {
            menuView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 1, blue: 1, alpha: 1)
        } else if (defaults.string(forKey: "background color") == "offwhite") {
            menuView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.8470588235, alpha: 1)
        } else if (defaults.string(forKey: "background color") == "dark") {
//            menuView.backgroundColor = #colorLiteral(red: 0.3349293172, green: 0.3487221599, blue: 0.3447707295, alpha: 1)
            menuView.backgroundColor = darkPopOut
        }
        
        if (menuView.backgroundColor == #colorLiteral(red: 0.9411764706, green: 1, blue: 1, alpha: 1) || menuView.backgroundColor == #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.8470588235, alpha: 1)) {
            currentScore.textColor = UIColor.black
            highScore.textColor = UIColor.black
        } else if (menuView.backgroundColor == darkPopOut) {
            currentScore.textColor = UIColor.white
            highScore.textColor = UIColor.white
        }
        
        menuView.layer.cornerRadius = 20
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOffset = .zero
        menuView.layer.shadowOpacity = 0.25
        menuView.layer.shadowRadius = 30
        
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOffset = .init(width: 0, height: 5)
        homeButton.layer.shadowOpacity = 0.15
        homeButton.layer.shadowRadius = 8
        
        newGame.layer.cornerRadius = 25
        resumeGame.layer.cornerRadius = 25
        homeButton.layer.cornerRadius = 25
        
        currentScore.text = "Score: \(currentScoreNum)"
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
