//
//  HomeScreenViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 5/1/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import GameKit
import BLTNBoard

class HomeScreenViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    let LEADERBOARD_ID = "yahtzi.leaderboard"
    
    let defaults = UserDefaults.standard

    // The current background style.
    var currentBackground = (name: "Dimmed", style: BLTNBackgroundViewStyle.dimmed)
    
    lazy var bulletinManager: BLTNItemManager = {
        let page = BLTNPageItem(title: "Welcome to Yahtzi")
        page.image = UIImage(named: "HowToPlay-128")

        page.descriptionText = "Would you like to see the tutorial?"
        page.actionButtonTitle = "Yes"
        page.alternativeButtonTitle = "Not now"
        
        page.actionHandler = { item in
            self.performSegue(withIdentifier: "homeToTutorial", sender: self)
        }

        page.alternativeHandler = { item in
            self.dismiss(animated: true, completion: nil)
        }
        
        return BLTNItemManager(rootItem: page)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        startGameButton.layer.cornerRadius = 25
        startGameButton.layer.shadowColor = UIColor.black.cgColor
        startGameButton.layer.shadowOffset = .init(width: 0, height: 5)
        startGameButton.layer.shadowOpacity = 0.2
        startGameButton.layer.shadowRadius = 7
        
        // Call the GC authentication controller
        authenticateLocalPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            print("should show bulletin")
            bulletinManager.showBulletin(above: self)
//            defaults.set(true, forKey: "didSeeTutorial")
    }
    
    // Play game button selected
    @IBAction func playGameButtonTapped(_ sender: UIButton) {
        // Increment the game count
        defaults.set(defaults.integer(forKey: "game_count") + 1, forKey: "game_count")
    }
    
    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

    // MARK: - Handling GameCenter view
    @IBAction func showGC(_ sender: UIButton) {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }
    
    // Delegate to dismiss the GC controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - AUTHENTICATE LOCAL PLAYER
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
             
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                     
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error!)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                 
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
    }
}
