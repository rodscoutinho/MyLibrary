//
//  Book.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 13/02/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import Foundation

class Book: CustomStringConvertible {
    var id: Int
    var author: String
    var genre: Genre
    var title: String
    var isbn: String
    
    init(id: Int, author: String, genre: Genre, title: String, isbn: String) {
        self.id = id
        self.author = author
        self.genre = genre
        self.title = title
        self.isbn = isbn
    }
    
    public var description: String {
        get {
            return "Id: \(self.id)\nTitle: \(self.title)\nGenre: \(self.genre.rawValue)\nAuthor: \(self.author)\nISBN: \(self.isbn)\n"
        }
    }
    
}

extension Book: Equatable {}

func ==(lhs: Book, rhs: Book) -> Bool { // Implement Equatable
    return lhs.id == rhs.id && lhs.title == rhs.title
}
