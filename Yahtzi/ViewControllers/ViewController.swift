//
//  ViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 9/10/19.
//  Copyright © 2019 Ben Buchanan. All rights reserved.
//

import UIKit
import GameKit
import GoogleMobileAds

class ViewController: UIViewController, DiceColorProtocol, BCProtocol, NewGameProtocol, PauseMenuProtocol, GADBannerViewDelegate, GKGameCenterControllerDelegate, GADInterstitialDelegate {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    var diceOne = 1
    var diceTwo = 2
    var diceThree = 3
    var diceFour = 4
    var diceFive = 5
    
    var turnCount = 0
    var bonusGoal = 63
    var bonusSum = 0
    var totalScore = 0
    
    var scoreButtonSelected = false
    
    var oneTapped = false
    var twoTapped = false
    var threeTapped = false
    var fourTapped = false
    var fiveTapped = false
        
    @IBOutlet weak var holdOne: UILabel!
    @IBOutlet weak var holdTwo: UILabel!
    @IBOutlet weak var holdThree: UILabel!
    @IBOutlet weak var holdFour: UILabel!
    @IBOutlet weak var holdFive: UILabel!
    
    @IBOutlet weak var ones: UIButton!
    @IBOutlet weak var twos: UIButton!
    @IBOutlet weak var threes: UIButton!
    @IBOutlet weak var fours: UIButton!
    @IBOutlet weak var fives: UIButton!
    @IBOutlet weak var sixes: UIButton!
    @IBOutlet weak var threeOfAKind: UIButton!
    @IBOutlet weak var fourOfAKind: UIButton!
    @IBOutlet weak var fullHouse: UIButton!
    @IBOutlet weak var smallStraight: UIButton!
    @IBOutlet weak var largeStraight: UIButton!
    @IBOutlet weak var chance: UIButton!
    @IBOutlet weak var yahtzee: UIButton!
    
    @IBOutlet weak var onesLabel: UILabel!
    @IBOutlet weak var twosLabel: UILabel!
    @IBOutlet weak var threesLabel: UILabel!
    @IBOutlet weak var foursLabel: UILabel!
    @IBOutlet weak var fivesLabel: UILabel!
    @IBOutlet weak var sixesLabel: UILabel!
    @IBOutlet weak var threeOfAKindLabel: UILabel!
    @IBOutlet weak var fourOfAKindLabel: UILabel!
    @IBOutlet weak var fullHouseLabel: UILabel!
    @IBOutlet weak var smallStraightLabel: UILabel!
    @IBOutlet weak var largeStraightLabel: UILabel!
    @IBOutlet weak var chanceLabel: UILabel!
    @IBOutlet weak var yahtzeeLabel: UILabel!
    
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    @IBOutlet weak var rollButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy var buttonArray = [ones, twos, threes, fours, fives, sixes, threeOfAKind, fourOfAKind, fullHouse, smallStraight, largeStraight, chance, yahtzee]

    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var imageFive: UIImageView!
    
    @IBOutlet weak var diceThemeButton: UIButton!
    @IBOutlet weak var backgroundThemeButton: UIButton!
    
    var diceFaceOne: UIImage? = nil
    var diceFaceTwo: UIImage? = nil
    var diceFaceThree: UIImage? = nil
    var diceFaceFour: UIImage? = nil
    var diceFaceFive: UIImage? = nil
    var diceFaceSix: UIImage? = nil
    
    lazy var imageArray = [ diceFaceOne, diceFaceTwo, diceFaceThree, diceFaceFour, diceFaceFive, diceFaceSix ]
    
    let random = GKRandomDistribution( lowestValue: 1, highestValue: 6 )
    
    var diceColor = "gray"
    var backColor = "white"
    
    var currentTextColor = "black"
    
    let defaults = UserDefaults.standard
    let highScoreKey = "high score"
    let diceColorKey = "dice color"
    let backgroundColorKey = "background color"
    var maxScore = 0
    
    var yahtzeeCounter = 0
    
    var addBonus = true
    var bonusAchieved = false
    
    // Gamecenter variables
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
         
    let LEADERBOARD_ID = "yahtzi.leaderboard"
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow time for interstitial to load
        self.interstitial = createAndLoadInterstitial()
        
        // Handling Google AdMob unless
        // they have purhcased remove ads
        if (!defaults.bool(forKey: "purchased")) {
            bannerView.delegate = self
            bannerView.adUnitID = "ca-app-pub-2208431788064222/6263274101"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
        setUpAppearance()
        
        maxScore = defaults.integer(forKey: highScoreKey)
        
        setUpForNewGame()
    }
    
    // Set up for a new game
    func setUpForNewGame() {
        for val in buttonArray {
            val?.isEnabled = false
            val?.titleLabel?.minimumScaleFactor = 0.4
            val?.titleLabel?.numberOfLines = 0
            val?.titleLabel?.adjustsFontSizeToFitWidth = true
        }
         
        imageOne.image = diceFaceOne
        imageTwo.image = diceFaceTwo
        imageThree.image = diceFaceThree
        imageFour.image = diceFaceFour
        imageFive.image = diceFaceFive
         
        imageOne.layer.borderColor = UIColor.black.cgColor
        imageTwo.layer.borderColor = UIColor.black.cgColor
        imageThree.layer.borderColor = UIColor.black.cgColor
        imageFour.layer.borderColor = UIColor.black.cgColor
        imageFive.layer.borderColor = UIColor.black.cgColor
         
        // Set default image borders
        if (defaults.string(forKey: diceColorKey) ?? diceColor == "white") {
            imageOne.layer.borderWidth = 1
            imageTwo.layer.borderWidth = 1
            imageThree.layer.borderWidth = 1
            imageFour.layer.borderWidth = 1
            imageFive.layer.borderWidth = 1
        } else {
            imageOne.layer.borderWidth = 0
            imageTwo.layer.borderWidth = 0
            imageThree.layer.borderWidth = 0
            imageFour.layer.borderWidth = 0
            imageFive.layer.borderWidth = 0
        }
         
        rollButton.setTitle("Start Game", for: .normal)
         
        // set all button titles to 0
        ones.setTitle(String(0), for: .normal)
        twos.setTitle(String(0), for: .normal)
        threes.setTitle(String(0), for: .normal)
        fours.setTitle(String(0), for: .normal)
        fives.setTitle(String(0), for: .normal)
        sixes.setTitle(String(0), for: .normal)
        threeOfAKind.setTitle(String(0), for: .normal)
        fourOfAKind.setTitle(String(0), for: .normal)
        fullHouse.setTitle(String(0), for: .normal)
        smallStraight.setTitle(String(0), for: .normal)
        largeStraight.setTitle(String(0), for: .normal)
        chance.setTitle(String(0), for: .normal)
        yahtzee.setTitle(String(0), for: .normal)
         
        holdOne.isHidden = true
        holdTwo.isHidden = true
        holdThree.isHidden = true
        holdFour.isHidden = true
        holdFive.isHidden = true
    }
    
    // Sets up appearance whether it is a new game or saved game
    func setUpAppearance() {
        setDiceColor(defaults.string(forKey: diceColorKey) ?? diceColor)
        setBackgroundColor(defaults.string(forKey: backgroundColorKey) ?? backColor)
        
        // set dice images corner radius
        imageOne.layer.cornerRadius = 12
        imageTwo.layer.cornerRadius = 12
        imageThree.layer.cornerRadius = 12
        imageFour.layer.cornerRadius = 12
        imageFive.layer.cornerRadius = 12
        
        // Setup roll button appearance
        rollButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rollButton.titleLabel?.minimumScaleFactor = 0.75
        rollButton.titleLabel?.adjustsFontForContentSizeCategory = true
        rollButton.layer.cornerRadius = 22.5
        
        // set all borders
        ones.layer.borderWidth = 2
        ones.layer.cornerRadius = 7
        twos.layer.borderWidth = 2
        twos.layer.cornerRadius = 7
        threes.layer.borderWidth = 2
        threes.layer.cornerRadius = 7
        fours.layer.borderWidth = 2
        fours.layer.cornerRadius = 7
        fives.layer.borderWidth = 2
        fives.layer.cornerRadius = 7
        sixes.layer.borderWidth = 2
        sixes.layer.cornerRadius = 7
        threeOfAKind.layer.borderWidth = 2
        threeOfAKind.layer.cornerRadius = 7
        fourOfAKind.layer.borderWidth = 2
        fourOfAKind.layer.cornerRadius = 7
        fullHouse.layer.borderWidth = 2
        fullHouse.layer.cornerRadius = 7
        smallStraight.layer.borderWidth = 2
        smallStraight.layer.cornerRadius = 7
        largeStraight.layer.borderWidth = 2
        largeStraight.layer.cornerRadius = 7
        chance.layer.borderWidth = 2
        chance.layer.cornerRadius = 7
        yahtzee.layer.borderWidth = 2
        yahtzee.layer.cornerRadius = 7
        
        // Setting up gesture recognizers for the dice
        imageOne.isUserInteractionEnabled = false;
        imageOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageOneTapped)))
        
        imageTwo.isUserInteractionEnabled = false;
        imageTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped)))
        
        imageThree.isUserInteractionEnabled = false;
        imageThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageThreeTapped)))
        
        imageFour.isUserInteractionEnabled = false;
        imageFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageFourTapped)))
        
        imageFive.isUserInteractionEnabled = false;
        imageFive.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageFiveTapped)))
    }
    
    // Compare the dice values to determine
    // points and available options
    func determineRoll() {
        var score = 0
        var sum = 0
        
        // Array containing the dice integer values
        let diceArray = [diceOne, diceTwo, diceThree, diceFour, diceFive]
        
        // Sum of all dice in the roll
        for val in diceArray {
            sum += val
        }
        
        // Counters for each dice
        var onesCounter = 0
        var twosCounter = 0
        var threesCounter = 0
        var foursCounter = 0
        var fivesCounter = 0
        var sixesCounter = 0
        
        // Setting the dice counters
        for val in diceArray {
            switch ( val ) {
            case 1:
                onesCounter += 1
            case 2:
                twosCounter += 1
            case 3:
                threesCounter += 1
            case 4:
                foursCounter += 1
            case 5:
                fivesCounter += 1
            case 6:
                sixesCounter += 1
            default:
                print( "Error" )
            }
        }
        
        // Array containing dice counters
        let counterArray = [onesCounter, twosCounter, threesCounter, foursCounter, fivesCounter, sixesCounter]
        
        // Booleans for determining whether or not
        // to display the scores
        var threeKind = false
        var fourKind = false
        var fullH = false
        var fiveKind = false
        var smallStr = false
        var largeStr = false
        
        // Determining if full house is available
        for val in counterArray {
            if ( val == 2 ) {
                for valTwo in counterArray {
                    if ( valTwo == 3 ) {
                        fullH = true
                    }
                }
            }
        }
        
        // Determining if small straight is available
        if ( onesCounter >= 1 && twosCounter >= 1 && threesCounter >= 1 && foursCounter >= 1 ) {
            smallStr = true
        } else if ( twosCounter >= 1 && threesCounter >= 1 && foursCounter >= 1 && fivesCounter >= 1 ) {
            smallStr = true
        } else if ( threesCounter >= 1 && foursCounter >= 1 && fivesCounter >= 1 && sixesCounter >= 1 ) {
            smallStr = true
        }
        
        // Determining if large straight is available
        if ( onesCounter == 1 && twosCounter == 1 && threesCounter == 1 && foursCounter == 1 && fivesCounter == 1 ) {
            largeStr = true
        } else if ( twosCounter == 1 && threesCounter == 1 && foursCounter == 1 && fivesCounter == 1 && sixesCounter == 1 ) {
            largeStr = true
        }
        
        // Determining if 3,4, or 5 of a kind is available
        for val in counterArray {
            if ( val == 3 ) {
                // Three of a kind achieved
                threeKind = true
                for num in diceArray {
                    score += num
                }
            } else if ( val == 4 ) {
                // Four of a kind achieved
                threeKind = true
                fourKind = true
                for num in diceArray {
                    score += num
                }
            } else if ( val == 5 ) {
                // Yahzee achieved
                threeKind = true
                fourKind = true
                fiveKind = true
                for num in diceArray {
                    score += num
                }
                yahtzeeCounter += 1
            }
        }
        
        // Setting the right side scores
        if ( threeKind && threeOfAKind.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            threeOfAKind.setTitle(String(score), for: .normal)
        } else if ( threeOfAKind.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            threeOfAKind.setTitle(String(0), for: .normal)
        }
        
        if ( fourKind && fourOfAKind.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fourOfAKind.setTitle(String(score), for: .normal)
        } else if ( fourOfAKind.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fourOfAKind.setTitle(String(0), for: .normal)
        }
        
        if ( fiveKind && yahtzee.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            yahtzee.setTitle(String(50), for: .normal)
        } else if ( yahtzee.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            yahtzee.setTitle(String(0), for: .normal)
        }
        
        if ( smallStr && smallStraight.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            smallStraight.setTitle(String(30), for: .normal)
        } else if (smallStraight.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) {
            smallStraight.setTitle(String(0), for: .normal)
        }
        
        if ( largeStr && largeStraight.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            largeStraight.setTitle(String(40), for: .normal)
        } else if (  largeStraight.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            largeStraight.setTitle(String(0), for: .normal)
        }
        
        if ( fullH && fullHouse.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fullHouse.setTitle(String(25), for: .normal)
        } else if ( fullHouse.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fullHouse.setTitle(String(0), for: .normal)
        }
        
        // Setting the chance roll
        if ( chance.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            chance.setTitle(String(sum), for: .normal)
        }
        
        // Setting the left side scores
        if ( onesCounter >= 1 && ones.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            ones.setTitle(String(onesCounter), for: .normal)
        } else if ( ones.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            ones.setTitle(String(0), for: .normal)
        }
        
        if ( twosCounter >= 1 && twos.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            twos.setTitle(String(2 * twosCounter), for: .normal)
        } else if ( twos.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            twos.setTitle(String(0), for: .normal)
        }
        
        if ( threesCounter >= 1 && threes.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            threes.setTitle(String(3 * threesCounter), for: .normal)
        } else if ( threes.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            threes.setTitle(String(0), for: .normal)
        }
        
        if ( foursCounter >= 1 && fours.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fours.setTitle(String(4 * foursCounter), for: .normal)
        } else if ( fours.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fours.setTitle(String(0), for: .normal)
        }
        
        if ( fivesCounter >= 1 && fives.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fives.setTitle(String(5 * fivesCounter), for: .normal)
        } else if ( fives.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            fives.setTitle(String(0), for: .normal)
        }
        
        if ( sixesCounter >= 1 && sixes.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            sixes.setTitle(String(6 * sixesCounter), for: .normal)
        } else if ( sixes.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
            sixes.setTitle(String(0), for: .normal)
        }
        
        // Setting all to 100 for consecutive yahtzees
        if (yahtzeeCounter > 1) {
            for val in buttonArray {
                if (val?.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) {
                    val?.setTitle(String(100), for: .normal)
                }
            }
            yahtzeeCounter -= 1
        }
        
    }
    
    @IBAction func rollDice(_ sender: UIButton) {
        
        imageOne.isUserInteractionEnabled = true
        imageTwo.isUserInteractionEnabled = true
        imageThree.isUserInteractionEnabled = true
        imageFour.isUserInteractionEnabled = true
        imageFive.isUserInteractionEnabled = true
        
        for val in buttonArray {
            if (val?.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) {
                val?.isEnabled = true
            }
        }
        
        if (scoreButtonSelected) {
            submitScore()
            
            // check if game is over
            let gameOver = isGameOver()
            if (gameOver) {
                // Set maxScore to be submitted to GameCenter
                maxScore = max(totalScore, defaults.integer(forKey: highScoreKey))
                defaults.set(maxScore, forKey: highScoreKey)
                
                // Submit score to GC leaderboard
                let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
                bestScoreInt.value = Int64(maxScore)
                GKScore.report([bestScoreInt]) { (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Best Score submitted to your Leaderboard!")
                    }
                }
                
                // end the game
                displayGameOverMenu()
                
                return
            }
            
            deselectImage(imageOne, holdOne)
            oneTapped = false
            deselectImage(imageTwo, holdTwo)
            twoTapped = false
            deselectImage(imageThree, holdThree)
            threeTapped = false
            deselectImage(imageFour, holdFour)
            fourTapped = false
            deselectImage(imageFive, holdFive)
            fiveTapped = false
        }
        
        turnCount += 1
        if (turnCount == 1) {
            // First roll of turn
            sender.setTitle("Roll Again", for: .normal)
        } else if (turnCount == 2) {
            sender.setTitle("Last Roll", for: .normal)
        } else if (turnCount == 3) {
            // Last roll
            sender.setTitle("Next Round", for: .normal)
            if (!scoreButtonSelected) {
                rollButton.isEnabled = false
                rollButton.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.7529411765, alpha: 1)
            }
        }
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.3 // or however long you want ...
        rotation.isCumulative = true
        rotation.repeatCount = 1.5
        
        if ( !oneTapped ) {
            diceOne = random.nextInt();
            imageOne.image = imageArray[ diceOne - 1 ]
            imageOne.layer.add(rotation, forKey: "rotationAnimation")
        }
        if ( !twoTapped ) {
            diceTwo = random.nextInt();
            imageTwo.image = imageArray[ diceTwo - 1 ]
            imageTwo.layer.add(rotation, forKey: "rotationAnimation")
        }
        if ( !threeTapped ) {
            diceThree = random.nextInt();
            imageThree.image = imageArray[ diceThree - 1 ]
            imageThree.layer.add(rotation, forKey: "rotationAnimation")
        }
        if ( !fourTapped ) {
            diceFour = random.nextInt();
            imageFour.image = imageArray[ diceFour - 1 ]
            imageFour.layer.add(rotation, forKey: "rotationAnimation")
        }
        if ( !fiveTapped ) {
            diceFive = random.nextInt();
            imageFive.image = imageArray[ diceFive - 1 ]
            imageFive.layer.add(rotation, forKey: "rotationAnimation")
        }
        
        determineRoll()
    }
    
    @objc func imageOneTapped(_ recognizer: UITapGestureRecognizer) {
        if ( !oneTapped ) {
            holdOne.isHidden = false
            imageOne.layer.borderColor = self.diceColor == "blue" ? UIColor.blue.cgColor : UIColor.systemBlue.cgColor
            imageOne.layer.borderWidth = 4
        } else {
            // unhighlight box
            deselectImage(imageOne, holdOne)
        }
        
        oneTapped = !oneTapped
    }
    
    @objc func imageTwoTapped(_ recognizer: UITapGestureRecognizer) {
        if ( !twoTapped ) {
            holdTwo.isHidden = false
            imageTwo.layer.borderColor = self.diceColor == "blue" ? UIColor.blue.cgColor : UIColor.systemBlue.cgColor
            imageTwo.layer.borderWidth = 4
        } else {
            deselectImage(imageTwo, holdTwo)
        }
        
        twoTapped = !twoTapped
        
    }
    
    @objc func imageThreeTapped(_ recognizer: UITapGestureRecognizer) {
        if ( !threeTapped ) {
            holdThree.isHidden = false
            imageThree.layer.borderColor = self.diceColor == "blue" ? UIColor.blue.cgColor : UIColor.systemBlue.cgColor
            imageThree.layer.borderWidth = 4
        } else {
            deselectImage(imageThree, holdThree)
        }
        
        threeTapped = !threeTapped
        
    }
    
    @objc func imageFourTapped(_ recognizer: UITapGestureRecognizer) {
        if ( !fourTapped ) {
            holdFour.isHidden = false
            imageFour.layer.borderColor = self.diceColor == "blue" ? UIColor.blue.cgColor : UIColor.systemBlue.cgColor
            imageFour.layer.borderWidth = 4
        } else {
            deselectImage(imageFour, holdFour)
        }
        
        fourTapped = !fourTapped
        
    }
    
    @objc func imageFiveTapped(_ recognizer: UITapGestureRecognizer) {
        if ( !fiveTapped ) {
            holdFive.isHidden = false
            imageFive.layer.borderColor = self.diceColor == "blue" ? UIColor.blue.cgColor : UIColor.systemBlue.cgColor
            imageFive.layer.borderWidth = 4
        } else {
            deselectImage(imageFive, holdFive)
        }
        
        fiveTapped = !fiveTapped
        
    }
    
    @IBAction func scoreButtonSelected(_ sender: UIButton) {
        if (sender.backgroundColor == #colorLiteral(red: 0.5748896003, green: 0.7073853612, blue: 1, alpha: 1)) {
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            scoreButtonSelected = false
            if (turnCount == 1) {
                rollButton.setTitle("Roll Again", for: .normal)
            } else if (turnCount == 2) {
                rollButton.setTitle("Last Roll", for: .normal)
            } else if (turnCount == 3) {
                rollButton.isEnabled = false
                rollButton.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.7529411765, alpha: 1)
            }
            return
        }
        if (sender.isEnabled) {
            scoreButtonSelected = true
            rollButton.isEnabled = true
            rollButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            rollButton.setTitle("Next Round", for: .normal)
            removeOtherButtonBackgrounds(sender)
            sender.backgroundColor = #colorLiteral(red: 0.5748896003, green: 0.7073853612, blue: 1, alpha: 1)
        }
    }
    
    // removes all backgrounds except the one selected
    func removeOtherButtonBackgrounds(_ button: UIButton) {
        for val in buttonArray {
            if (val != button && val!.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ) {
                val?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
    }
    
    // removes background from all buttons
    func removeAllButtonBackgrounds() {
        for val in buttonArray {
            val?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    func submitScore() {
        for val in buttonArray {
            if (val?.backgroundColor == #colorLiteral(red: 0.5748896003, green: 0.7073853612, blue: 1, alpha: 1)) {
                let tempScore = Int((val?.currentTitle)!) ?? 0
                totalScore += tempScore
                val?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                val?.isEnabled = false
                scoreButtonSelected = false
                
                if (val == ones || val == twos || val == threes || val == fours || val == fives || val == sixes) {
                    
                    bonusSum += tempScore
                    if (bonusSum >= bonusGoal && addBonus) {
                        bonusAchieved = true
                        bonus.text = "35 bonus points achieved!"
                        bonus.font = bonus.font.withSize(11)
                        totalScore += 35
                        addBonus = false
                    } else if (addBonus) {
                        bonus.font = bonus.font.withSize(12)
                        bonus.text = "\(bonusGoal - bonusSum) remaining"
                    }
                    if (ones.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && twos.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && threes.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && fours.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && fives.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && sixes.backgroundColor == #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) && !bonusAchieved) {
                        // Bonus was not achieved
                        bonus.text = "No bonus"
                    }
                }
            }
        }
        scoreLabel.text = "Score: \(totalScore)"
        turnCount = 0
    }
    
    // deselect a dice image
    func deselectImage(_ image: UIImageView, _ hold: UILabel) {
        hold.isHidden = true
        image.layer.borderColor = UIColor.black.cgColor
        
        if (diceColor == "white") {
            image.layer.borderWidth = 1
        } else {
            image.layer.borderWidth = 0
        }
    }
    
    // check all scores to see if game is over
    func isGameOver() -> Bool {
        for val in buttonArray {
            if (val?.backgroundColor != #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) {
                return false
            }
        }
        return true
    }
    
    // Set the dice face images based on color
    func setDiceColor(_ popUpDiceColor: String) {
        if (popUpDiceColor == "red") {
            diceFaceOne = UIImage(named: "custom-red-7")
            diceFaceTwo = UIImage(named: "custom-red-8")
            diceFaceThree = UIImage(named: "custom-red-9")
            diceFaceFour = UIImage(named: "custom-red-10")
            diceFaceFive = UIImage(named: "custom-red-11")
            diceFaceSix = UIImage(named: "custom-red-12")
        } else if (popUpDiceColor == "white") {
            diceFaceOne = UIImage(named: "custom-white-1")
            diceFaceTwo = UIImage(named: "custom-white-2")
            diceFaceThree = UIImage(named: "custom-white-3")
            diceFaceFour = UIImage(named: "custom-white-4")
            diceFaceFive = UIImage(named: "custom-white-5")
            diceFaceSix = UIImage(named: "custom-white-6")
        } else if (popUpDiceColor == "gray") {
            diceFaceOne = UIImage(named: "custom-gray-1")
            diceFaceTwo = UIImage(named: "custom-gray-2")
            diceFaceThree = UIImage(named: "custom-gray-3")
            diceFaceFour = UIImage(named: "custom-gray-4")
            diceFaceFive = UIImage(named: "custom-gray-5")
            diceFaceSix = UIImage(named: "custom-gray-6")
        } else if (popUpDiceColor == "blue") {
            diceFaceOne = UIImage(named: "Group")
            diceFaceTwo = UIImage(named: "Group 2")
            diceFaceThree = UIImage(named: "Group 3")
            diceFaceFour = UIImage(named: "Group 4")
            diceFaceFive = UIImage(named: "Group 5")
            diceFaceSix = UIImage(named: "Group 6")
        }
        
        self.diceColor = popUpDiceColor
        defaults.set(popUpDiceColor, forKey: diceColorKey)
        
        imageArray = [diceFaceOne, diceFaceTwo, diceFaceThree, diceFaceFour, diceFaceFive, diceFaceSix]
        
        imageOne.image = imageArray[diceOne - 1]
        imageTwo.image = imageArray[diceTwo - 1]
        imageThree.image = imageArray[diceThree - 1]
        imageFour.image = imageArray[diceFour - 1]
        imageFive.image = imageArray[diceFive - 1]
        
        if (diceColor == "white") {
            imageOne.layer.borderWidth = 1
            imageTwo.layer.borderWidth = 1
            imageThree.layer.borderWidth = 1
            imageFour.layer.borderWidth = 1
            imageFive.layer.borderWidth = 1
        } else {
            imageOne.layer.borderWidth = 0
            imageTwo.layer.borderWidth = 0
            imageThree.layer.borderWidth = 0
            imageFour.layer.borderWidth = 0
            imageFive.layer.borderWidth = 0
        }
    
    }
    
    func setBackgroundColor(_ popUpBC: String) {
        self.backColor = popUpBC
        defaults.set(popUpBC, forKey: backgroundColorKey)
        if (popUpBC == "white") {
            mainView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 1, blue: 1, alpha: 1)
            if (currentTextColor != "black") {
                changeFontsToBlack()
                currentTextColor = "black"
            }
        } else if (popUpBC == "offwhite") {
            mainView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.8470588235, alpha: 1)
            if (currentTextColor != "black") {
                changeFontsToBlack()
                currentTextColor = "black"
            }
        } else if (popUpBC == "dark") {
            mainView.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
            if (currentTextColor != "white") {
                changeFontsToWhite()
                currentTextColor = "white"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDiceColorSeg" {
            let diceThemeVC: PopUpViewController = segue.destination as! PopUpViewController
            diceThemeVC.delegate = self
        }
        if segue.identifier == "getBackgroudColorSeg" {
            let backgroundThemeVC: BackgroundColorPopUpViewController = segue.destination as! BackgroundColorPopUpViewController
            backgroundThemeVC.delegate = self
        }
        if segue.identifier == "gameOverMenuSeg" {
            let menuPopUpVC: MenuViewController = segue.destination as! MenuViewController
            menuPopUpVC.delegate = self
        }
        if segue.identifier == "pauseMenuSeg" {
            let pauseMenuVC: PauseMenuViewController = segue.destination as! PauseMenuViewController
            pauseMenuVC.delegate = self
        }
        if segue.destination is BackgroundColorPopUpViewController
        {
            let bcpuVC = segue.destination as? BackgroundColorPopUpViewController
            bcpuVC?.backgroundColor = self.backColor
        }
        if segue.destination is MenuViewController {
            let gameOverMenuVC = segue.destination as? MenuViewController
            gameOverMenuVC?.interstitial = self.interstitial
            gameOverMenuVC?.finalScore = totalScore
            gameOverMenuVC?.highScore = maxScore
        }
        if segue.destination is PopUpViewController {
            let diceColorPopUpVC = segue.destination as? PopUpViewController
            diceColorPopUpVC?.popUpDiceColor = self.diceColor
        }
        if segue.destination is PauseMenuViewController {
            let pauseMenuVC = segue.destination as? PauseMenuViewController
            
//            var currentGame = GameState(ones: self.ones.currentTitle, twos: self.twos.currentTitle, threes: self.threes.currentTitle, fours: self.fours.currentTitle, fives: self.fives.currentTitle, sixes: self.sixes.currentTitle, bonus: self.bonusSum, score: self.score, diceOne: self.diceOne, diceTwo: self.diceTwo, diceThree: self.diceThree, diceFour: self.diceFour, diceFive: self.diceFive)
//            print(currentGame)
            
            pauseMenuVC?.interstitial = self.interstitial
            pauseMenuVC?.currentScoreNum = totalScore
            pauseMenuVC?.highScoreNum = maxScore
        }
    }
    
    // Change font to white when background is dark
    func changeFontsToWhite() {
        // Change button text to white
        ones.setTitleColor(UIColor.white, for: .normal)
        twos.setTitleColor(UIColor.white, for: .normal)
        threes.setTitleColor(UIColor.white, for: .normal)
        fours.setTitleColor(UIColor.white, for: .normal)
        fives.setTitleColor(UIColor.white, for: .normal)
        sixes.setTitleColor(UIColor.white, for: .normal)
        threeOfAKind.setTitleColor(UIColor.white, for: .normal)
        fourOfAKind.setTitleColor(UIColor.white, for: .normal)
        fullHouse.setTitleColor(UIColor.white, for: .normal)
        smallStraight.setTitleColor(UIColor.white, for: .normal)
        largeStraight.setTitleColor(UIColor.white, for: .normal)
        chance.setTitleColor(UIColor.white, for: .normal)
        yahtzee.setTitleColor(UIColor.white, for: .normal)
    
        // Change labels to white
        onesLabel.textColor = UIColor.white
        twosLabel.textColor = UIColor.white
        threesLabel.textColor = UIColor.white
        foursLabel.textColor = UIColor.white
        fivesLabel.textColor = UIColor.white
        sixesLabel.textColor = UIColor.white
        bonus.textColor = UIColor.white
        bonusLabel.textColor = UIColor.white
        threeOfAKindLabel.textColor = UIColor.white
        fourOfAKindLabel.textColor = UIColor.white
        fullHouseLabel.textColor = UIColor.white
        smallStraightLabel.textColor = UIColor.white
        largeStraightLabel.textColor = UIColor.white
        chanceLabel.textColor = UIColor.white
        yahtzeeLabel.textColor = UIColor.white
        onesLabel.textColor = UIColor.white
        
        // Change hold labels to white
        holdOne.textColor = UIColor.white
        holdTwo.textColor = UIColor.white
        holdThree.textColor = UIColor.white
        holdFour.textColor = UIColor.white
        holdFive.textColor = UIColor.white
        
        // Change score label to white
        scoreLabel.textColor = UIColor.white
        
        // Change button borders to white
        ones.layer.borderColor = UIColor.white.cgColor
        twos.layer.borderColor = UIColor.white.cgColor
        threes.layer.borderColor = UIColor.white.cgColor
        fours.layer.borderColor = UIColor.white.cgColor
        fives.layer.borderColor = UIColor.white.cgColor
        sixes.layer.borderColor = UIColor.white.cgColor
        threeOfAKind.layer.borderColor = UIColor.white.cgColor
        fourOfAKind.layer.borderColor = UIColor.white.cgColor
        fullHouse.layer.borderColor = UIColor.white.cgColor
        smallStraight.layer.borderColor = UIColor.white.cgColor
        largeStraight.layer.borderColor = UIColor.white.cgColor
        chance.layer.borderColor = UIColor.white.cgColor
        yahtzee.layer.borderColor = UIColor.white.cgColor
    }
    
    // Change font to black when background is light
    func changeFontsToBlack() {
        // Change button text to black
        ones.setTitleColor(UIColor.black, for: .normal)
        twos.setTitleColor(UIColor.black, for: .normal)
        threes.setTitleColor(UIColor.black, for: .normal)
        fours.setTitleColor(UIColor.black, for: .normal)
        fives.setTitleColor(UIColor.black, for: .normal)
        sixes.setTitleColor(UIColor.black, for: .normal)
        threeOfAKind.setTitleColor(UIColor.black, for: .normal)
        fourOfAKind.setTitleColor(UIColor.black, for: .normal)
        fullHouse.setTitleColor(UIColor.black, for: .normal)
        smallStraight.setTitleColor(UIColor.black, for: .normal)
        largeStraight.setTitleColor(UIColor.black, for: .normal)
        chance.setTitleColor(UIColor.black, for: .normal)
        yahtzee.setTitleColor(UIColor.black, for: .normal)
    
        // Change labels to black
        onesLabel.textColor = UIColor.black
        twosLabel.textColor = UIColor.black
        threesLabel.textColor = UIColor.black
        foursLabel.textColor = UIColor.black
        fivesLabel.textColor = UIColor.black
        sixesLabel.textColor = UIColor.black
        bonus.textColor = UIColor.black
        bonusLabel.textColor = UIColor.black
        threeOfAKindLabel.textColor = UIColor.black
        fourOfAKindLabel.textColor = UIColor.black
        fullHouseLabel.textColor = UIColor.black
        smallStraightLabel.textColor = UIColor.black
        largeStraightLabel.textColor = UIColor.black
        chanceLabel.textColor = UIColor.black
        yahtzeeLabel.textColor = UIColor.black
        onesLabel.textColor = UIColor.black
        
        // Change hold labels to black
        holdOne.textColor = UIColor.black
        holdTwo.textColor = UIColor.black
        holdThree.textColor = UIColor.black
        holdFour.textColor = UIColor.black
        holdFive.textColor = UIColor.black
        
        // Change score label to black
        scoreLabel.textColor = UIColor.black
        
        // Change button borders to black
        ones.layer.borderColor = UIColor.black.cgColor
        twos.layer.borderColor = UIColor.black.cgColor
        threes.layer.borderColor = UIColor.black.cgColor
        fours.layer.borderColor = UIColor.black.cgColor
        fives.layer.borderColor = UIColor.black.cgColor
        sixes.layer.borderColor = UIColor.black.cgColor
        threeOfAKind.layer.borderColor = UIColor.black.cgColor
        fourOfAKind.layer.borderColor = UIColor.black.cgColor
        fullHouse.layer.borderColor = UIColor.black.cgColor
        smallStraight.layer.borderColor = UIColor.black.cgColor
        largeStraight.layer.borderColor = UIColor.black.cgColor
        chance.layer.borderColor = UIColor.black.cgColor
        yahtzee.layer.borderColor = UIColor.black.cgColor
    }
    
    // Display the game over pop up menu
    func displayGameOverMenu() {
        performSegue(withIdentifier: "gameOverMenuSeg", sender: self)
    }
    
    // Start a brand new game
    // Automatically rolls dice and starts turn
    func startNewGame() {
        scoreButtonSelected = false
        
        for val in buttonArray {
            val?.setTitle(String(0), for: .normal)
            val?.backgroundColor = UIColor.clear
            val?.isEnabled = false
        }
        
        deselectImage(imageOne, holdOne)
        deselectImage(imageTwo, holdTwo)
        deselectImage(imageThree, holdThree)
        deselectImage(imageFour, holdFour)
        deselectImage(imageFive, holdFive)
        
        oneTapped = false
        twoTapped = false
        threeTapped = false
        fourTapped = false
        fiveTapped = false
        
        totalScore = 0
        scoreLabel.text = "Score: \(totalScore)"
        
        bonusSum = 0
        bonus.text = "35 if subtotal is 63 or over"
        bonus.font = bonus.font.withSize(11)
        addBonus = true
        bonusAchieved = false
        
        holdOne.isHidden = true
        holdTwo.isHidden = true
        holdThree.isHidden = true
        holdFour.isHidden = true
        holdFive.isHidden = true
        
        turnCount = 0
        yahtzeeCounter = 0
        rollButton.setTitle("Start Game", for: .normal)
        rollButton.isEnabled = true
        rollButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        rollDice(self.rollButton)
        
        // Increment the game count
        defaults.set(defaults.integer(forKey: "game_count") + 1, forKey: "game_count")
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
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        print("dismissed")
    }
    
    // MARK: - Animate banner ad loading
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
    
    // MARK: - Handle loading interstitial ad
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-2208431788064222/8474476226")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("vc1 interstitial did dismiss")
      interstitial = createAndLoadInterstitial()
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func displayInterstitial() {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
            defaults.set(0, forKey: "game_count")
        } else {
          print("Ad wasn't ready")
        }
    }
    
    func setInterstitial() {
        self.interstitial = createAndLoadInterstitial()
    }
    
    // MARK: - OPEN GAME CENTER LEADERBOARD
    func checkGCLeaderboard() {
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
    
    // Check GC Leaderboard
    @IBAction func checkGC(_ sender: UIButton) {
        checkGCLeaderboard()
    }
    
}

