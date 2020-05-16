//
//  BackgroundColorPopUpViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 4/24/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

protocol BCProtocol {
    func setBackgroundColor(_ popUpBC: String)
}

class BackgroundColorPopUpViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var offWhiteButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    
    var backgroundColor = ""
    var delegate: BCProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        whiteButton.layer.cornerRadius = 27.5
        offWhiteButton.layer.cornerRadius = 27.5
        darkButton.layer.cornerRadius = 27.5
        determineBorders()
        
        popUpView.layer.shadowColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1490196078, alpha: 1)
        popUpView.layer.shadowOpacity = 0.25
        popUpView.layer.shadowOffset = .zero
        popUpView.layer.shadowRadius = 50
    }
    
    @IBAction func whiteButtonSelected(_ sender: UIButton) {
        backgroundColor = "white"
        determineBorders()
        delegate?.setBackgroundColor(backgroundColor)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func offWhiteButtonSelected(_ sender: UIButton) {
        backgroundColor = "offwhite"
        determineBorders()
        delegate?.setBackgroundColor(backgroundColor)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func darkButtonSelected(_ sender: UIButton) {
        backgroundColor = "dark"
        determineBorders()
        delegate?.setBackgroundColor(backgroundColor)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismissView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func determineBorders() {
        if (backgroundColor == "white") {
            whiteButton.layer.borderWidth = 2.5
            whiteButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        } else if (backgroundColor == "offwhite") {
            offWhiteButton.layer.borderWidth = 2.5
            offWhiteButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            
            whiteButton.layer.borderWidth = 1
            whiteButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.7529411765, alpha: 1)
        } else if (backgroundColor == "dark") {
            darkButton.layer.borderWidth = 2.5
            darkButton.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            
            whiteButton.layer.borderWidth = 1
            whiteButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.7529411765, alpha: 1)
        }
    }
    
}
