
//
//  BookViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit

enum Genre: String {
    case Action = "Action and Adventure"
    case Anthology = "Anthology"
    case Art = "Art"
    case Autobiographies = "Autobiographies"
    case Biographies = "Biographies"
    case Childrens = "Childrens"
    case Comics = "Comics"
    case Cookbooks = "Cookbooks"
    case Diaries = "Diaries"
    case Dictionaries = "Dictionaries"
    case Drama = "Drama"
    case Encyclopedias = "Encyclopedias"
    case Fantasy = "Fantasy"
    case Guide = "Guide"
    case Health = "Health"
    case History = "History"
    case Horror = "Horror"
    case Journals = "Journals"
    case Math = "Math"
    case Mystery = "Mystery"
    case Poetry = "Poetry"
    case Prayer = "Prayer books"
    case Religion = "Religion, Spirituality & New Age"
    case Romance = "Romance"
    case Satire = "Satire"
    case Science = "Science"
    case Scifi = "Science fiction"
    case SelfHelp = "Self help"
    case Series = "Series"
    case Travel = "Travel"
    case Trilogy = "Trilogy"
    
    static let allValues = [Action, Anthology, Art, Autobiographies, Biographies, Childrens, Comics, Cookbooks, Diaries, Dictionaries, Drama, Encyclopedias, Fantasy, Guide, Health, History, Horror, Journals, Math, Mystery, Poetry, Prayer, Religion, Romance, Satire, Science, Scifi, SelfHelp, Series, Travel, Trilogy]
    
}

protocol AddBookTableViewControllerDelegate: class {
    func addBookTableViewController(_ controller: AddBookTableViewController, didFinishAdding book: Book)
}

class AddBookTableViewController: UITableViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genrePickerView: UIPickerView!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var book: Book?
    weak var delegate: AddBookTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
            title = "Edit Book"
            
            titleTextField.text = book.title
            authorTextField.text = book.author
            
            if let genreIndex = Genre.allValues.index(of: book.genre) {
                genrePickerView.selectRow(genreIndex, inComponent: 0, animated: true)
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        
        // Editing book
        if let book = book {
            book.title = titleTextField.text!
            book.author = authorTextField.text!
            book.genre = Genre.allValues[genrePickerView.selectedRow(inComponent: 0)]
            book.isbn = isbnTextField.text!
        } else {
            // Adding book
            let book = Book(id: 2000, author: authorTextField.text!, genre: Genre.allValues[genrePickerView.selectedRow(inComponent: 0)], title: titleTextField.text!, isbn: isbnTextField.text!)
            book.title = titleTextField.text!
            book.author = authorTextField.text!
            book.genre = Genre.allValues[genrePickerView.selectedRow(inComponent: 0)]
            book.isbn = isbnTextField.text!
            
            delegate?.addBookTableViewController(self, didFinishAdding: book)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {

                imagePicker.sourceType = .camera
                present(imagePicker, animated: true, completion: nil)
                
            } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
                
            }
        }
        
    }
    
}

extension AddBookTableViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Genre.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Genre.allValues[row].rawValue
    }
    
}

extension AddBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        coverImageView.image = image
        dismiss(animated: true, completion: nil)
        
    }
    
}























