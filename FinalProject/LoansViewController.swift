//
//  ViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import CoreData

struct LoanTableViewCellIdentifiers {
    static let finishedLoanCell = "FinishedLoanTableViewCell"
    static let openLoanCell = "OpenLoanTableViewCell"
}

class LoansViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var loans = [LoanMO]()
    
    var fetchResultController: NSFetchedResultsController<LoanMO>!
    
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
        
        let fetchRequest: NSFetchRequest<LoanMO> = LoanMO.fetchRequest()
        let sortDescriptor1 = NSSortDescriptor(key: "returnDate", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "expectedReturnDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    loans = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? "" {
        case "addLoan":
            
            let navController = segue.destination as! UINavigationController
            let loanViewController = navController.topViewController as! LoanTableViewController
            loanViewController.delegate = self
            
        case "editLoan":
            
            if let cell = sender {
                
                if let indexPath = tableView.indexPath(for: cell as! UITableViewCell) {
                    let loan = loans[indexPath.row]
                    
                    let navController = segue.destination as! UINavigationController
                    let loanViewController = navController.topViewController as! LoanTableViewController
                    loanViewController.delegate = self
                    loanViewController.loanToEdit = loan
                }
                
            }
            
        default:
            break
        }
        
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) { }
    
}

extension LoansViewController: LoanTableViewControllerDelegate {
    
    func loanTableViewController(_ controller: LoanTableViewController, didFinishEditingLoan loan: LoanMO) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if let index = loans.index(of: loan) {
                loans[index] = loan
                appDelegate.saveContext()
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func loanTableViewController(_ controller: LoanTableViewController, didFinishCreatingLoan loan: LoanMO) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension LoansViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let openLoanCell = tableView.cellForRow(at: indexPath) as? OpenLoanTableViewCell {
            performSegue(withIdentifier: "editLoan", sender: openLoanCell)
        } else if let finishedLoanCell = tableView.cellForRow(at: indexPath) as? FinishedLoanTableViewCell {
            performSegue(withIdentifier: "editLoan", sender: finishedLoanCell)
        }
        
    }
    
}

extension LoansViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loan = loans[indexPath.row]
        if loan.returnDate != nil {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: LoanTableViewCellIdentifiers.finishedLoanCell, for: indexPath) as! FinishedLoanTableViewCell
            
            cell.memberLabel.text = loan.member!.name
            cell.loansDescriptionLabel.text = "\(loan.books!.count) book(s) borrowed"
            cell.checkouDate.text = dateFormatter.string(from: loan.loanDate! as Date)
            cell.expectedReturnDate.text = dateFormatter.string(from: loan.expectedReturnDate! as Date)
            cell.returnDate.text = dateFormatter.string(from: loan.returnDate! as Date)
         
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: LoanTableViewCellIdentifiers.openLoanCell, for: indexPath) as! OpenLoanTableViewCell
            
            cell.memberNameLabel.text = loan.member!.name
            cell.loanDescriptionLabel.text = "\(loan.books!.count) book(s) borrowed"
            cell.checkoutDateLabel.text = dateFormatter.string(from: loan.loanDate! as Date)
            cell.expectedReturnDateLabel.text = dateFormatter.string(from: loan.expectedReturnDate! as Date)
            
            cell.selectionStyle = .none
            
            return cell
            
        }
        
    }
    
}

extension LoansViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchObjects = controller.fetchedObjects {
            loans = fetchObjects as! [LoanMO]
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

