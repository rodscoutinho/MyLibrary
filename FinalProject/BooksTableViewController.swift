//
//  BooksTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 22/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import CoreData

protocol BooksTableViewControllerDelegate: class {
    func booksTableViewControllerDidCancel(_ controller: BooksTableViewController)
    func booksTableViewController(_ controller: BooksTableViewController, didFinishSelecting book: BookMO)
}

class BooksTableViewController: UITableViewController {
    
    var booksCollection = [BookMO]()
    var alreadySelectedBooks: [BookMO]?
    
    weak var delegate: BooksTableViewControllerDelegate?
    
    var fetchResultController: NSFetchedResultsController<BookMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<BookMO> = BookMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    booksCollection = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        booksUnavailable()
        removeUnavailableBooksFromBooksCollection()
    }
    
    private func removeUnavailableBooksFromBooksCollection() {
        guard let booksToRemove = alreadySelectedBooks, booksToRemove.count > 0 else {
            return
        }
        
        for book in booksToRemove {
            if let index = booksCollection.index(of: book) {
                booksCollection.remove(at: index)
            }
        }
    }
    
    private func booksUnavailable() {
    
        let fetchRequest: NSFetchRequest<LoanMO> = LoanMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "expectedReturnDate", ascending: true)
    
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    let loans = fetchedObjects
                    for loan in loans {
                        if loan.returnDate == nil {
                            for book in loan.books! {
                                alreadySelectedBooks?.append(book as! BookMO)
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    
    }
    
    @IBAction func cancelBookSelection(_ sender: UIBarButtonItem) {
        delegate?.booksTableViewControllerDidCancel(self)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType != .checkmark {
                let book = booksCollection[indexPath.row]
                delegate?.booksTableViewController(self, didFinishSelecting: book)
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return booksCollection.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        let book = booksCollection[indexPath.row]
        
        if let alreadySelectedBooks = alreadySelectedBooks {
            if alreadySelectedBooks.contains(book) {
                cell.accessoryType = .checkmark
            }
        } else {
            cell.accessoryType = .detailDisclosureButton
        }
        
        cell.textLabel!.text = book.title

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addBook" {
            
            let navController = segue.destination as! UINavigationController
            let addBookController = navController.topViewController as! AddBookTableViewController
            addBookController.delegate = self
            
        } else if segue.identifier == "editBook" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            let book = booksCollection[indexPath.row]
            
            let navController = segue.destination as! UINavigationController
            let addBookController = navController.topViewController as! AddBookTableViewController
            addBookController.book = book
            addBookController.delegate = self
            
        }
        
    }

}

extension BooksTableViewController: AddBookTableViewControllerDelegate {

    func addBookTableViewControllerDidCancel(_ controller: AddBookTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addBookTableViewController(_ controller: AddBookTableViewController, didFinishEditing book: BookMO) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if let index = booksCollection.index(of: book) {
                booksCollection[index] = book
                appDelegate.saveContext()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func addBookTableViewController(_ controller: AddBookTableViewController, didFinishAdding book: BookMO) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension BooksTableViewController: NSFetchedResultsControllerDelegate {
    
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
            booksCollection = fetchObjects as! [BookMO]
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}






















