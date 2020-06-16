//
//  StatsTableViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 6/15/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {
    
    @IBOutlet weak var mainView: UITableView!
    
    @IBOutlet weak var gamesStartedView: UIView!
    @IBOutlet weak var gamesCompletedView: UIView!
    @IBOutlet weak var numberOfYahtzisView: UIView!
    @IBOutlet weak var lowScoreView: UIView!
    @IBOutlet weak var highScoreView: UIView!
    
    @IBOutlet weak var statsLabel: UILabel!
    
    @IBOutlet weak var gamesStartedLabel: UILabel!
    @IBOutlet weak var gamesStartedNum: UILabel!
    @IBOutlet weak var gamesCompletedLabel: UILabel!
    @IBOutlet weak var gamesCompletedNum: UILabel!
    @IBOutlet weak var numberOfYahtzisLabel: UILabel!
    @IBOutlet weak var numberOfYahtzisNum: UILabel!
    @IBOutlet weak var lowScoreLabel: UILabel!
    @IBOutlet weak var lowScoreNum: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var highScoreNum: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch UserDefaults.standard.string(forKey: "background color") {
        case "white":
            mainView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 1, blue: 1, alpha: 1)
        case "offwhite":
            mainView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9215686275, blue: 0.8470588235, alpha: 1)
        case "dark":
            mainView.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
        default:
            mainView.backgroundColor = UIColor.groupTableViewBackground
        }
        
        let cellArray = [gamesStartedView, gamesCompletedView, numberOfYahtzisView, lowScoreView, highScoreView]
        
        for cell in cellArray {
            cell?.layer.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9176470588, blue: 0.937254902, alpha: 1)
        }
        
        gamesStartedNum.text = String(defaults.integer(forKey: "games started"))
        gamesCompletedNum.text = String(defaults.integer(forKey: "games completed"))
        numberOfYahtzisNum.text = String(defaults.integer(forKey: "number of yahtzis"))
        lowScoreNum.text = String(defaults.integer(forKey: "low score"))
        highScoreNum.text = String(defaults.integer(forKey: "high score"))

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
