//
//  RulesViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/7/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var rulesText: UITextView!

    @IBOutlet weak var playGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playGameButton.layer.cornerRadius = 22.5
        
        rulesText.attributedText = attributedText()
        
        rulesText.layer.cornerRadius = 10
        rulesText.layer.borderWidth = 1
        rulesText.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func attributedText() -> NSAttributedString {

        let string = "Left Section – Each number in this section is a total of the respective dice that are rolled.  For example, two 3’s would be a score of 6 in the 3’s category.  Three 5’s would be a score of 15 in the 5’s category.  A subtotal of 63 or over in this section results in a bonus 35 points!\n\nThree of A Kind – Three dice of the same number are needed to score this category.  The score is a sum of all the dice.\n\nFour of A Kind –  Four dice of the same number are needed to score this category.  The score is a sum of all the dice.\n\nFull House – Three dice of the same number and another two dice of the same number are needed to score this category.  The score is 25 points.\n\nSmall Straight – Four consecutive numbers are needed to score this category.  For example, 2-3-4-5 or 1-2-3-4.  The score is 30 points.\n\nLarge Straight – Five consecutive numbers are needed to score this category.  The score is 30 points.\n\nChance – This category is just the total of all dice.\n\nYahtzi – A Yahtzi is when five dice of the same number are rolled.  This results in a score of 50 in the Yahtzi category.  Additional Yahtzi’s allow a score of 100 to be placed in any available category, as long as there is not a 0 in the Yahtzi box." as NSString

        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)])

        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        let blueFontAttribute = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]

        // Part of string to be bold
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Left Section"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Left Section"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Three of A Kind"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Three of A Kind"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Four of A Kind"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Four of A Kind"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Full House"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Full House"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Small Straight"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Small Straight"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Large Straight"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Large Straight"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Chance"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Chance"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Yahtzi"))
        attributedString.addAttributes(blueFontAttribute, range: string.range(of: "Yahtzi"))

        // 4
        return attributedString
    }
    
    // dismiss to home screen
    @IBAction func getStarted(_ sender: UIButton) {
        if (UserDefaults.standard.bool(forKey: "tutorialShown")) {
            // first launch
            UserDefaults.standard.set(false, forKey: "tutorialShown")
            performSegue(withIdentifier: "tutToHomeSeg", sender: self)
            
        } else {
            // not first launch
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
