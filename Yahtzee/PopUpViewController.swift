//
//  PopUpViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/24/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func setDiceColor(_ popUpDiceColor: String)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var popUpDiceColor = ""
    var delegate: MyProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
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
