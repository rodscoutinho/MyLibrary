//
//  LoanTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit

protocol LoanTableViewControllerDelegate: class {
    func loanTableViewController(_ controller: LoanTableViewController, didFinishCreatingLoan loan: Loan)
}

class LoanTableViewController: UITableViewController {
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        return picker
    }()
    
    var member: MemberMO?
    var books = [BookMO]()
    
    var delegate: LoanTableViewControllerDelegate?
    
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
        
        let loan = Loan(member: member, books: books, expectedReturnDate: Date())
        delegate?.loanTableViewController(self, didFinishCreatingLoan: loan)
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
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
            
        } else {
            
            cell.addSubview(datePicker)
            
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Member"
        case 1:
            return "Book(s)"
        case 2:
            return "Expected return date"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 216
        }
        
        return 44
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
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
































