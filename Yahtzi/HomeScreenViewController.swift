//
//  HomeScreenViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 5/1/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import GameKit

// local player
private var localPlayer = GKLocalPlayer.local

// leaderbaord id from iTunes
private let leaderboardID = "com.example.top"
private var scores: [(playerName: String, score: Int)]?
private var leaderboard: GKLeaderboard?

class GameCenter {
    static let shared = GameCenter()
    
    private init() {
        
    }
}

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGameButton.layer.cornerRadius = 25
    }
    
    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

}
