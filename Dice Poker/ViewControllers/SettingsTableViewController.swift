//
//  SettingsTableViewController.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/5/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import UIKit
import StoreKit

class SettingsTableViewController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    let defaults = UserDefaults.standard
    
    var product_id = "yahtzi.remove.ads"
    var productsRequest = SKProductsRequest()
    var validProducts = [SKProduct]()
    var productIndex = 0

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
        
        fetchAvailableProducts()
        
         self.clearsSelectionOnViewWillAppear = true
    }
    
    // Dismiss UITableViewController
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateApp(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1513819811?action=write-review") {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func restorePurchases(_ sender: UITapGestureRecognizer) {
        restorePurchase()
    }
    
    @IBAction func removeAds(_ sender: UITapGestureRecognizer) {
        productIndex = 0
        purchaseMyProduct(validProducts[productIndex])
    }
    
    func fetchAvailableProducts()  {
        let productIdentifiers = NSSet(objects:
            "yahtzi.remove.ads"         // 0
        )
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    
    
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        if (response.products.count > 0) {
            validProducts = response.products
            
            // 1st IAP Product
            let removeAdsProd = response.products[0] as SKProduct
            print("1st product: " + removeAdsProd.localizedDescription)
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
    
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    
    func purchaseMyProduct(_ product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else { print("Purchases are disabled on your device!") }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    let successfulPurchaseAlert = UIAlertController(title: "Purchase Successful!", message:
                        "Ads Removed", preferredStyle: .alert)
                    successfulPurchaseAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(successfulPurchaseAlert, animated: true, completion: nil)
                    defaults.set(true, forKey: "purchased")
                    removeAdsCell.accessoryType = .checkmark
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .failed:
                    print("Payment has failed.")
                    let purchaseFailedAlert = UIAlertController(title: "Purchase Failed", message:
                        "Please try again", preferredStyle: .alert)
                    purchaseFailedAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(purchaseFailedAlert, animated: true, completion: nil)
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    let restoredAlert = UIAlertController(title: "Restored Purchases", message:
                        "Purchase successfully restored", preferredStyle: .alert)
                    restoredAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(restoredAlert, animated: true, completion: nil)
                    defaults.set(true, forKey: "purchased")
                    print("Purchase has been successfully restored!")
                    removeAdsCell.accessoryType = .checkmark
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
        }}}
    }
    
    
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self as SKPaymentTransactionObserver)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("The Payment was successfull!")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0 || section == 2) {
            return 2
        } else  {
            return 1
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
