//
//  LoanTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import CoreData

protocol LoanTableViewControllerDelegate: class {
    func loanTableViewController(_ controller: LoanTableViewController, didFinishEditingLoan loan: LoanMO)
    func loanTableViewController(_ controller: LoanTableViewController, didFinishCreatingLoan loan: LoanMO)
}

class LoanTableViewController: UITableViewController {
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        
        if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            picker.minimumDate = tomorrow
        } else {
            picker.minimumDate = Date()
        }
        
        return picker
    }()
    
    var member: MemberMO?
    var books = [BookMO]()
    
    var loanToEdit: LoanMO?
    
    var delegate: LoanTableViewControllerDelegate?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loanToEdit = loanToEdit {
            if loanToEdit.returnDate != nil {
                title = "Loan Details"
            } else {
                title = "Edit Loan"
            }
        
            member = loanToEdit.member
            for book in loanToEdit.books! {
                books.append(book as! BookMO)
            }
            
            datePicker.date = loanToEdit.loanDate! as Date
            datePicker.isEnabled = false
            
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @IBAction func saveLoan(_ sender: UIBarButtonItem) {
        
        guard let member = member else {
            let alertController = UIAlertController(title: "Member not selected", message: "Select a member before trying to save the loan", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if books.count == 0 {
            let alertController = UIAlertController(title: "Book(s) not selected", message: "Select at least one book before trying to save the loan", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if datePicker.date <= Date() {
            let alertController = UIAlertController(title: "Invalid return date", message: "Please provide a return date later than today", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
        
            let loan = LoanMO(context: appDelegate.persistentContainer.viewContext)
            loan.member = member
            
            for book in books {
                loan.addToBooks(book)
            }
            loan.loanDate = NSDate()
            loan.expectedReturnDate = datePicker.date as NSDate

            delegate?.loanTableViewController(self, didFinishCreatingLoan: loan)
            
        }

        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if loanToEdit != nil {
            return 4
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            
            if let loanToEdit = loanToEdit {
                return loanToEdit.books!.count
            }
            
            if books.count == 0 {
                return 1
            } else {
                return books.count + 1
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanCell", for: indexPath)
        
        if indexPath.section == 0 {
            if let member = member {
                cell.textLabel?.text = member.name
            }
        } else if indexPath.section == 1 {
            
            if indexPath.row > books.count - 1 {
                cell.textLabel?.text = "Add a book"
                cell.textLabel?.textColor = UIColor.lightGray
            } else {
                cell.textLabel?.text = books[indexPath.row].title
            }
            
        } else if indexPath.section == 2 {
            
            cell.addSubview(datePicker)
            
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            
            let centerXConstraint = NSLayoutConstraint(item: datePicker, attribute: .centerX, relatedBy: .equal, toItem: datePicker.superview, attribute: .centerX, multiplier: 1, constant: 0)
            centerXConstraint.isActive = true
            
            let centerYConstraint = NSLayoutConstraint(item: datePicker, attribute: .centerY, relatedBy: .equal, toItem: datePicker.superview, attribute: .centerY, multiplier: 1, constant: 0)
            centerYConstraint.isActive = true
            
        } else {
            
            if let loanToEdit = loanToEdit {
                
                if loanToEdit.returnDate != nil {
                    cell.textLabel?.text = dateFormatter.string(from: loanToEdit.returnDate! as Date)
                } else {
                    let returnButton = UIButton()
                    returnButton.setTitle("Return book(s)", for: .normal)
                    returnButton.addTarget(self, action: #selector(returnBooks), for: .touchUpInside)
                    returnButton.backgroundColor = UIColor.orange
                    returnButton.tintColor = UIColor.white
                    returnButton.sizeToFit()
                    
                    returnButton.translatesAutoresizingMaskIntoConstraints = false
                    
                    cell.addSubview(returnButton)
                    
                    let centerXConstraint = NSLayoutConstraint(item: returnButton, attribute: .centerX, relatedBy: .equal, toItem: returnButton.superview, attribute: .centerX, multiplier: 1, constant: 0)
                    centerXConstraint.isActive = true
                    
                    let centerYConstraint = NSLayoutConstraint(item: returnButton, attribute: .centerY, relatedBy: .equal, toItem: returnButton.superview, attribute: .centerY, multiplier: 1, constant: 0)
                    centerYConstraint.isActive = true
                }
                
            }
            
        }
    
        return cell
        
    }
    
    func returnBooks() {
        
        let alertController = UIAlertController(title: "Loan return", message: "Are you sure you want to finalize this loan?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let finalizeAction = UIAlertAction(title: "Finalize", style: .default) { (action) in
            
            if let loanToEdit = self.loanToEdit {
            
                loanToEdit.returnDate = NSDate()
                
                let loanDate = loanToEdit.loanDate! as Date
                let returnDate = loanToEdit.returnDate! as Date
                let expectedReturnDate = loanToEdit.expectedReturnDate! as Date
                
                if returnDate > expectedReturnDate {
                    loanToEdit.daysOfDelay = Int32(Date.daysBetween(start: expectedReturnDate, end: returnDate))
                }
                loanToEdit.duration = Int32(Date.daysBetween(start: loanDate, end: returnDate))
                
                self.delegate?.loanTableViewController(self, didFinishEditingLoan: loanToEdit)
                
            }
            
        }
        
        alertController.addAction(finalizeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Member"
        case 1:
            return "Book(s)"
        case 2:
            return "Expected return date"

        case 3:
            if let loanToEdit = loanToEdit {
                if loanToEdit.returnDate != nil {
                    return "Return date"
                } else {
                    return "Return book(s)"
                }
            }
            return ""
            
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if loanToEdit != nil {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else {
        
            if indexPath.section == 0 {
                performSegue(withIdentifier: "showMembers", sender: self)
            } else {
                if indexPath.row == books.count {
                    performSegue(withIdentifier: "showBooks", sender: self)
                } else {
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 216
        }
        
        return 44
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if loanToEdit != nil {
            return false
        }
        
        if indexPath.section == 0 {
            return false
        } else if indexPath.section == 1 {
            if indexPath.row > books.count - 1 {
                return false
            } else {
                return true
            }
        }
        
        return false
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMembers" {
            
            let navController = segue.destination as! UINavigationController
            let membersController = navController.topViewController as! MembersTableViewController
            
            membersController.delegate = self
            
        } else if segue.identifier == "showBooks" {
        
            let navController = segue.destination as! UINavigationController
            let booksController = navController.topViewController as! BooksTableViewController
            booksController.alreadySelectedBooks = books
            booksController.delegate = self
        
        }
        
    }
    
    @IBAction func unwindToAddLoan(segue: UIStoryboardSegue) { }
    
}

extension LoanTableViewController: MembersTableViewControllerDelegate {
    
    func membersTableViewController(_ controller: MembersTableViewController, didFinishSelecting member: MemberMO) {
        self.member = member
        
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoanTableViewController: BooksTableViewControllerDelegate {
    
    func booksTableViewControllerDidCancel(_ controller: BooksTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func booksTableViewController(_ controller: BooksTableViewController, didFinishSelecting book: BookMO) {
        let indexPath = IndexPath(row: books.count, section: 1)
        
        books.append(book)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension Date {
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
        
    }
    
}






























