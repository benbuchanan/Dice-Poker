//
//  PopUpViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 4/24/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

protocol DiceColorProtocol {
    func setDiceColor(_ popUpDiceColor: String)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var whiteDiceImage: UIButton!
    @IBOutlet weak var grayDiceImage: UIButton!
    @IBOutlet weak var blueDiceImage: UIButton!
    @IBOutlet weak var redDiceImage: UIButton!
    
    
    @IBOutlet weak var blueBarOne: UIImageView!
    @IBOutlet weak var blueBarTwo: UIImageView!
    @IBOutlet weak var blueBarThree: UIImageView!
    @IBOutlet weak var blueBarFour: UIImageView!
    
    var popUpDiceColor = ""
    var delegate: DiceColorProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueBarOne.isHidden = true
        blueBarTwo.isHidden = true
        blueBarThree.isHidden = true
        blueBarFour.isHidden = true
        
        whiteDiceImage.imageView?.layer.cornerRadius = 10
        grayDiceImage.imageView?.layer.cornerRadius = 10
        blueDiceImage.imageView?.layer.cornerRadius = 10
        redDiceImage.imageView?.layer.cornerRadius = 10
        
        whiteDiceImage.imageView?.layer.borderWidth = 1
        whiteDiceImage.imageView?.layer.borderColor = UIColor.black.cgColor
        
        determineSelection()
        
        containerView.layer.shadowColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1490196078, alpha: 1)
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 50
    }

    @IBAction func dismissView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func whiteDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "white"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func grayDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "gray"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func blueDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "blue"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func redDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "red"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func determineSelection() {
        if (popUpDiceColor == "white") {
            
            blueBarOne.isHidden = false
            blueBarTwo.isHidden = true
            blueBarThree.isHidden = true
            blueBarFour.isHidden = true
            
        } else if (popUpDiceColor == "gray") {
            
            blueBarOne.isHidden = true
            blueBarTwo.isHidden = false
            blueBarThree.isHidden = true
            blueBarFour.isHidden = true
            
        } else if (popUpDiceColor == "blue") {
            
            blueBarOne.isHidden = true
            blueBarTwo.isHidden = true
            blueBarThree.isHidden = false
            blueBarFour.isHidden = true
            
        } else if (popUpDiceColor == "red") {
            
            blueBarOne.isHidden = true
            blueBarTwo.isHidden = true
            blueBarThree.isHidden = true
            blueBarFour.isHidden = false
            
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
