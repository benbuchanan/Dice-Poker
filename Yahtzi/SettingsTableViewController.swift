//
//  SettingsTableViewController.swift
//  Yahtzee
//
//  Created by Ben Buchanan on 5/5/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import StoreKit

class SettingsTableViewController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    let defaults = UserDefaults.standard
    
    var product_id = "yahtzi.remove.ads"

    @IBOutlet weak var removeAdsCell: UITableViewCell!
    @IBOutlet weak var restorePurchasesCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        
        if (defaults.bool(forKey: "purchased")) {
            // They have removed ads
            removeAdsCell.accessoryType = .checkmark
        } else {
            removeAdsCell.accessoryType = .none
        }
        
         self.clearsSelectionOnViewWillAppear = true
    }
    
    // Dismiss UITableViewController
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func restorePurchases(_ sender: UITapGestureRecognizer) {
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            print("Error")
        }
    }
    
    @IBAction func removeAds(_ sender: UITapGestureRecognizer) {
        if (SKPaymentQueue.canMakePayments()) {
            let productID:NSSet = NSSet(array: [self.product_id as NSString]);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fetching Products");
        } else {
            print("Can't make purchase");
        }
    }
    
    func buyProduct(product: SKProduct) {
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
    }
    
    // MARK: - StoreKit delegate functions

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        print(response.products)
        let count : Int = response.products.count
        if (count>0) {

            let validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.product_id as String) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                self.buyProduct(product: validProduct)
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{

                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased")
                    defaults.set(true, forKey: "purchased")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)

                    break;
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .restored:
                    print("Already Purchased")
                    //Do unlocking etc stuff here in case of restor

                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                default:
                    break;
                }
            }
        }
    }


    //If an error occurs, the code will go to this function
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        // Show some alert
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
