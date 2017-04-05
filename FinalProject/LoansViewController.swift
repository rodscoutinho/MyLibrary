//
//  ViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit

struct LoanTableViewCellIdentifiers {
    static let finishedLoanCell = "FinishedLoanTableViewCell"
    static let openLoanCell = "OpenLoanTableViewCell"
}

class LoansViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var loans = [Loan]()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: LoanTableViewCellIdentifiers.finishedLoanCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LoanTableViewCellIdentifiers.finishedLoanCell)
        
        cellNib = UINib(nibName: LoanTableViewCellIdentifiers.openLoanCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LoanTableViewCellIdentifiers.openLoanCell)
        
        tableView.estimatedRowHeight = 156
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "addLoan":
            
            let navController = segue.destination as! UINavigationController
            let loanViewController = navController.topViewController as! LoanTableViewController
            loanViewController.delegate = self
            
        default:
            break
        }
        
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) { }
    
}

extension LoansViewController: LoanTableViewControllerDelegate {
    
    func loanTableViewController(_ controller: LoanTableViewController, didFinishCreatingLoan loan: Loan) {
        
        let indexPath = IndexPath(row: loans.count, section: 0)
        
        loans.append(loan)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
}

extension LoansViewController: UITableViewDelegate {
    
}

extension LoansViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loan = loans[indexPath.row]
        if loan.returnDate != nil {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: LoanTableViewCellIdentifiers.finishedLoanCell, for: indexPath) as! FinishedLoanTableViewCell
            
            cell.memberLabel.text = loan.member.name
            cell.loansDescriptionLabel.text = "\(loan.books.count) book(s) borrowed"
            cell.checkouDate.text = dateFormatter.string(from: loan.loanDate)
            cell.expectedReturnDate.text = dateFormatter.string(from: loan.expectedReturnDate)
            cell.returnDate.text = dateFormatter.string(from: loan.returnDate!)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: LoanTableViewCellIdentifiers.openLoanCell, for: indexPath) as! OpenLoanTableViewCell
            
            cell.memberNameLabel.text = loan.member.name
            cell.loanDescriptionLabel.text = "\(loan.books.count) book(s) borrowed"
            cell.checkoutDateLabel.text = dateFormatter.string(from: loan.loanDate)
            cell.expectedReturnDateLabel.text = dateFormatter.string(from: loan.expectedReturnDate)
            
            return cell
            
        }
        
    }
    
}
