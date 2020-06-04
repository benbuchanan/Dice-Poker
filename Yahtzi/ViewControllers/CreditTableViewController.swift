//
//  CreditTableViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/14/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class CreditTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions to open links
    @IBAction func linkForCellZero(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.flaticon.com/authors/freepik") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkForCellOne(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.flaticon.com/authors/roundicons") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkForCellTwo(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.flaticon.com/authors/smashicons") {
            UIApplication.shared.open(url)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
//
//        // Configure the cell...
//        print(indexPath)
//        print(cell)
//
//        return cell
//    }

}
