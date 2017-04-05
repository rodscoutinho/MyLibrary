//
//  BooksTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 22/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit

protocol BooksTableViewControllerDelegate: class {
    func booksTableViewController(_ controller: BooksTableViewController, didFinishSelecting book: Book)
}

class BooksTableViewController: UITableViewController {
    
    var booksCollection = [Book]()
    var alreadySelectedBooks: [Book]?
    weak var delegate: BooksTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let book1 = Book(id: 1, author: "Moran, Cathleen", genre: Genre(rawValue: "Childrens")! , title: "Grumpy Cat: Misadventures", isbn: "9-13485-062-1")
        let book2 = Book(id: 2, author: "Leon, Elvis", genre: Genre(rawValue: "Action and Adventure")!, title: "The Giving Tree", isbn: "7-96810-292-6")
        let book3 = Book(id: 3, author: "Ware, Kimberly", genre: Genre(rawValue: "Action and Adventure")!, title: "The Giving Tree", isbn: "7-96810-292-6")
        let book4 = Book(id: 4, author: "Olsen, Ursula", genre: Genre(rawValue: "Action and Adventure")!, title: "This Savage Song", isbn: "4-36857-462-7")
        let book5 = Book(id: 5, author: "Moran, Cathleen", genre: Genre(rawValue: "Childrens")!, title: "Grumpy Cat: Misadventures", isbn: "9-13485-062-1")
        let book6 = Book(id: 6, author: "Moran, Cathleen", genre: Genre(rawValue: "Childrens")!, title: "Grumpy Cat: Misadventures", isbn: "9-13485-062-1")
        let book7 = Book(id: 7, author: "Moran, Cathleen", genre: Genre(rawValue: "Childrens")!, title: "Grumpy Cat: Misadventures", isbn: "9-13485-062-1")
        let book8 = Book(id: 8, author: "Wise, Edward", genre: Genre(rawValue: "Satire")!, title: "This Is Not My Hat", isbn: "4-69511-812-5")
        let book9 = Book(id: 9, author: "Davis, Tanek", genre: Genre(rawValue: "Action and Adventure")!, title: "I Am the Messenger", isbn: "1-10893-277-9")
        let book10 = Book(id: 10, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book11 = Book(id: 11, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book12 = Book(id: 12, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book13 = Book(id: 13, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book14 = Book(id: 14, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book15 = Book(id: 15, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book16 = Book(id: 16, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "Harry Potter And The Half Blood Prince", isbn: "1-51108-970-8")
        let book17 = Book(id: 17, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "Canada 150 - Colouring our History", isbn: "3-90983-714-2")
        let book18 = Book(id: 18, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "Canada Year by Year", isbn: "4-98367-400-9")
        let book19 = Book(id: 19, author: "Moran, Cathleen", genre: Genre(rawValue: "Satire")!, title: "Shin-Chis Canoe", isbn: "6-53322-000-8")
        let book20 = Book(id: 20, author: "Kane, Isaac", genre: Genre(rawValue: "Satire")!, title: "When I Was Eight", isbn: "8-80186-294-4")
        let book21 = Book(id: 21, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "Alberta: Revised", isbn: "5-36781-945-9")
        let book22 = Book(id: 22, author: "Moran, Cathleen", genre: Genre(rawValue: "Fantasy")!, title: "Who Was Queen Elizabeth?", isbn: "3-35190-101-6")
        let book23 = Book(id: 23, author: "Moran, Cathleen", genre: Genre(rawValue: "Satire")!, title: "Salt to the Sea", isbn: "6-25942-160-3")
        let book24 = Book(id: 24, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "History Year by Year", isbn: "6-19946-821-8")
        let book25 = Book(id: 25, author: "Moran, Cathleen", genre: Genre(rawValue: "Romance")!, title: "Not My Girl", isbn: "7-88184-267-0")
        let book26 = Book(id: 26, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "Alberta: Revised", isbn: "5-36781-945-9")
        let book27 = Book(id: 27, author: "Kane, Isaac", genre: Genre(rawValue: "Satire")!, title: "When I Was Eight", isbn: "8-80186-294-4")
        let book28 = Book(id: 28, author: "Kane, Isaac", genre: Genre(rawValue: "Satire")!, title: "When I Was Eight", isbn: "8-80186-294-4")
        let book29 = Book(id: 29, author: "Kane, Isaac", genre: Genre(rawValue: "Satire")!, title: "When I Was Eight", isbn: "8-80186-294-4")
        let book30 = Book(id: 30, author: "Kane, Isaac", genre: Genre(rawValue: "Satire")!, title: "When I Was Eight", isbn: "8-80186-294-4")
        let book31 = Book(id: 31, author: "Moran, Cathleen", genre: Genre(rawValue: "Science fiction")!, title: "Caraval", isbn: "2-38422-947-5")
        let book32 = Book(id: 32, author: "Cash, Barbara", genre: Genre(rawValue: "Science fiction")!, title: "The Ultimate Book of Cities", isbn: "7-82967-486-2")
        let book33 = Book(id: 33, author: "Cash, Barbara", genre: Genre(rawValue: "Childrens")!, title: "Pete the Cat and the Cool Cat Boogie", isbn: "1-84749-125-7")
        let book34 = Book(id: 34, author: "Cash, Barbara", genre: Genre(rawValue: "Romance")!, title: "Beautiful Oops!", isbn: "7-25964-669-8")
        let book35 = Book(id: 35, author: "Cash, Barbara", genre: Genre(rawValue: "Childrens")!, title: "Harry Potter: Coloring Book", isbn: "5-23902-861-6")
        let book36 = Book(id: 36, author: "Cash, Barbara", genre: Genre(rawValue: "Childrens")!, title: "Littlest Pet Shop: I Love to Draw!", isbn: "9-30738-187-0")
        let book37 = Book(id: 37, author: "Cash, Barbara", genre: Genre(rawValue: "Horror")!, title: "A Court of Wings and Ruin", isbn: "5-78424-598-3")
        let book38 = Book(id: 38, author: "Trevino, Leila", genre: Genre(rawValue: "Science fiction")!, title: "Light in the Lions Den", isbn: "6-73473-052-3")
        let book39 = Book(id: 39, author: "Trevino, Leila", genre: Genre(rawValue: "Science fiction")!, title: "Light in the Lions Den", isbn: "6-73473-052-3")
        let book40 = Book(id: 40, author: "Trevino, Leila", genre: Genre(rawValue: "Science fiction")!, title: "Light in the Lions Den", isbn: "6-73473-052-3")
        
        booksCollection.append(book1)
        booksCollection.append(book2)
        booksCollection.append(book3)
        booksCollection.append(book4)
        booksCollection.append(book5)
        booksCollection.append(book6)
        booksCollection.append(book7)
        booksCollection.append(book8)
        booksCollection.append(book9)
        booksCollection.append(book10)
        booksCollection.append(book11)
        booksCollection.append(book12)
        booksCollection.append(book13)
        booksCollection.append(book14)
        booksCollection.append(book15)
        booksCollection.append(book16)
        booksCollection.append(book17)
        booksCollection.append(book18)
        booksCollection.append(book19)
        booksCollection.append(book20)
        booksCollection.append(book21)
        booksCollection.append(book22)
        booksCollection.append(book23)
        booksCollection.append(book24)
        booksCollection.append(book25)
        booksCollection.append(book26)
        booksCollection.append(book27)
        booksCollection.append(book28)
        booksCollection.append(book29)
        booksCollection.append(book30)
        booksCollection.append(book31)
        booksCollection.append(book32)
        booksCollection.append(book33)
        booksCollection.append(book34)
        booksCollection.append(book35)
        booksCollection.append(book36)
        booksCollection.append(book37)
        booksCollection.append(book38)
        booksCollection.append(book39)
        booksCollection.append(book40)
        
        booksCollection.sort {
            $0 < $1
        }
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
        
        cell.accessoryType = .none
        if let alreadySelectedBooks = alreadySelectedBooks {
            if alreadySelectedBooks.contains(book) {
                cell.accessoryType = .checkmark
            }
        }
        
        cell.textLabel?.text = book.title

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    func addBookTableViewController(_ controller: AddBookTableViewController, didFinishAdding book: Book) {
        booksCollection.append(book)
        booksCollection.sort {
            $0 < $1
        }
        
        if let bookIndex = booksCollection.index(of: book) {
            let indexPath = IndexPath(row: bookIndex, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            dismiss(animated: true, completion: nil)
        } else {
            tableView.reloadData()
        }
    }

}

func < (lhs: Book, rhs: Book) -> Bool {
    return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending
}
























