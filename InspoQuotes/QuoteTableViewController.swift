import UIKit
import StoreKit // framework  of the StoreKit

class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver { // SKPaymentTransactionObserver StoreKit protocol
    
    
    let productID = "string of the productID of the developer"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the current view controller as an observer to the default SKPaymentQueue.
        // SKPaymentQueue is responsible for managing and processing in-app purchases.
        SKPaymentQueue.default().add(self)
    }
    
    // MARK: - Table view data source - to show the quotes
    // assign number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return number of quotes
        return quotesToShow.count + 1
    }
    // show quotes in the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell with identifier of the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        // if there are less cells than the number of rows
        if indexPath.row < quotesToShow.count{
            // assign the text to the cell
            cell.textLabel?.text = quotesToShow[indexPath.row]
            // assign the number of lines to 0 in case is needed more than 1 line of text
            cell.textLabel?.numberOfLines = 0
        }
        else {
            cell.textLabel?.text = "Get more quotes" // if there are more text for the last cell
            cell.textLabel?.textColor = UIColor.blue // change the colour
            cell.accessoryType = .detailDisclosureButton // to indicate that can be clicked
        }
        return cell
    }
    
    // MARK: - Table view delegate method - to click in the last cell
    // function of the last cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            buyPremiumQuotes()
        }
        // deselected the row once clicked
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: In-app purchases method
    // function to buy Premium Quotes
    func buyPremiumQuotes(){
        // class of StoreKit to make sure that the user can make payments
        if SKPaymentQueue.canMakePayments() {
            // create new variable with the class SKMutablePayment of StoreKit
            let paymentRequest = SKMutablePayment()
            // assign the product identifier to our productID
            paymentRequest.productIdentifier = productID
        }
        else {
            print("User can't make payments")
        }
    }
    // function to check payments (needs developer account) - It needs to be checked in a physical device also
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // loop in all the availables transactions
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                // user payment succesful - finish transaction
                SKPaymentQueue.default().finishTransaction(transaction)
            }
            else if transaction.transactionState == .failed {
                // catch the error
                if let error = transaction.error{
                    // catch the localized description
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error : \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            }
        }
    }
        
        @IBAction func restorePressed(_ sender: UIBarButtonItem) {
            
        }
        
        
    }
