//
//  LoanMO+CoreDataProperties.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 2017-04-05.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import Foundation
import CoreData


extension LoanMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoanMO> {
        return NSFetchRequest<LoanMO>(entityName: "LoanMO")
    }

    @NSManaged public var daysOfDelay: Int32
    @NSManaged public var duration: Int32
    @NSManaged public var expectedReturnDate: NSDate?
    @NSManaged public var loanDate: NSDate?
    @NSManaged public var returnDate: NSDate?
    @NSManaged public var books: NSOrderedSet?
    @NSManaged public var member: MemberMO?

}

// MARK: Generated accessors for books
extension LoanMO {

    @objc(insertObject:inBooksAtIndex:)
    @NSManaged public func insertIntoBooks(_ value: BookMO, at idx: Int)

    @objc(removeObjectFromBooksAtIndex:)
    @NSManaged public func removeFromBooks(at idx: Int)

    @objc(insertBooks:atIndexes:)
    @NSManaged public func insertIntoBooks(_ values: [BookMO], at indexes: NSIndexSet)

    @objc(removeBooksAtIndexes:)
    @NSManaged public func removeFromBooks(at indexes: NSIndexSet)

    @objc(replaceObjectInBooksAtIndex:withObject:)
    @NSManaged public func replaceBooks(at idx: Int, with value: BookMO)

    @objc(replaceBooksAtIndexes:withBooks:)
    @NSManaged public func replaceBooks(at indexes: NSIndexSet, with values: [BookMO])

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookMO)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookMO)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSOrderedSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSOrderedSet)

}
