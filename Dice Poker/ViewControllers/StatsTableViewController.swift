//
//  StatsTableViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 6/15/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import FirebaseAnalytics

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
    
    let offwhiteBackground = #colorLiteral(red: 0.8705882353, green: 0.8470588235, blue: 0.8078431373, alpha: 1)
    let offwhiteCell = #colorLiteral(red: 0.9411764706, green: 0.9176470588, blue: 0.8823529412, alpha: 1)
    let darkCell = #colorLiteral(red: 0.1176470588, green: 0.1215686275, blue: 0.1411764706, alpha: 1)
    let whiteCell = #colorLiteral(red: 0.937254902, green: 0.9568627451, blue: 0.9764705882, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-StatsViewed",
            AnalyticsParameterItemName: "StatsViewed",
            AnalyticsParameterContentType: "cont"
        ])
        
        gamesStartedNum.minimumScaleFactor = 0.75
        gamesStartedNum.adjustsFontSizeToFitWidth = true
        gamesCompletedNum.minimumScaleFactor = 0.75
        gamesCompletedNum.adjustsFontSizeToFitWidth = true
        numberOfYahtzisNum.minimumScaleFactor = 0.75
        numberOfYahtzisNum.adjustsFontSizeToFitWidth = true
        highScoreNum.minimumScaleFactor = 0.75
        highScoreNum.adjustsFontSizeToFitWidth = true
        lowScoreNum.minimumScaleFactor = 0.75
        lowScoreNum.adjustsFontSizeToFitWidth = true
        
        
        let backColor = defaults.string(forKey: "background color")
        
        switch backColor {
        case "white":
            mainView.backgroundColor = UIColor.white
            setTextBlack()
        case "offwhite":
            mainView.backgroundColor = offwhiteBackground
            setTextBlack()
        case "dark":
            mainView.backgroundColor = UIColor.black
            setTextWhite()
        default:
            mainView.backgroundColor = UIColor.white
        }
        
        let cellArray = [gamesStartedView, gamesCompletedView, numberOfYahtzisView, lowScoreView, highScoreView]
        
        for cell in cellArray {
            switch backColor {
            case "offwhite":
                cell?.backgroundColor = offwhiteCell
            case "dark":
                cell?.backgroundColor = darkCell
            default:
                cell?.backgroundColor = whiteCell
            }
        }
        
        gamesStartedNum.text = String(defaults.integer(forKey: "games started"))
        gamesCompletedNum.text = String(defaults.integer(forKey: "games completed"))
        numberOfYahtzisNum.text = String(defaults.integer(forKey: "number of yahtzis"))
        lowScoreNum.text = String(defaults.integer(forKey: "low score"))
        highScoreNum.text = String(defaults.integer(forKey: "high score"))

    }
    
    func setTextWhite() {
        statsLabel.textColor = UIColor.white
        gamesStartedLabel.textColor = UIColor.white
        gamesStartedNum.textColor = UIColor.white
        gamesCompletedLabel.textColor = UIColor.white
        gamesCompletedNum.textColor = UIColor.white
        numberOfYahtzisLabel.textColor = UIColor.white
        numberOfYahtzisNum.textColor = UIColor.white
        lowScoreLabel.textColor = UIColor.white
        lowScoreNum.textColor = UIColor.white
        highScoreLabel.textColor = UIColor.white
        highScoreNum.textColor = UIColor.white
    }
    
    func setTextBlack() {
        statsLabel.textColor = UIColor.black
        gamesStartedLabel.textColor = UIColor.black
        gamesStartedNum.textColor = UIColor.black
        gamesCompletedLabel.textColor = UIColor.black
        gamesCompletedNum.textColor = UIColor.black
        numberOfYahtzisLabel.textColor = UIColor.black
        numberOfYahtzisNum.textColor = UIColor.black
        lowScoreLabel.textColor = UIColor.black
        lowScoreNum.textColor = UIColor.black
        highScoreLabel.textColor = UIColor.black
        highScoreNum.textColor = UIColor.black
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
