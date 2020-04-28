//
//  PopUpViewController.swift
//  Yahtzee
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
    
    var popUpDiceColor = ""
    var delegate: DiceColorProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.shadowColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1490196078, alpha: 1)
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 50
    }

    @IBAction func dismissView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "clear"
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
    
    @IBAction func blackDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "black"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func yellowDiceSelected(_ sender: UIButton) {
        popUpDiceColor = "yellow"
        if (self.delegate != nil) {
            delegate?.setDiceColor(popUpDiceColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
}
