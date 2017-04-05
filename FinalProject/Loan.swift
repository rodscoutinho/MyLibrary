//
//  Loan.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 2017-04-04.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit

class Loan {
    
    private static var internalId: Int = 0
    var id: Int
    var books: [BookMO]
    var member: MemberMO
    var loanDate: Date
    var expectedReturnDate: Date
    var returnDate: Date?
    var daysOfDelay: Int?
    var duration: Int?
    var fine: Double?
    
    init(member: MemberMO, books: [BookMO], expectedReturnDate: Date) {
        Loan.internalId += 1
        self.id = Loan.internalId
        self.books = books
        self.member = member
        self.loanDate = Date()
        self.expectedReturnDate = expectedReturnDate
    }
    
}
