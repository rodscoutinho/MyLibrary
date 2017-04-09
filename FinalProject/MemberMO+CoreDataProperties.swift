//
//  MemberMO+CoreDataProperties.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 2017-04-05.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import Foundation
import CoreData


extension MemberMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberMO> {
        return NSFetchRequest<MemberMO>(entityName: "MemberMO")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var loans: NSOrderedSet?

}

// MARK: Generated accessors for loans
extension MemberMO {

    @objc(insertObject:inLoansAtIndex:)
    @NSManaged public func insertIntoLoans(_ value: LoanMO, at idx: Int)

    @objc(removeObjectFromLoansAtIndex:)
    @NSManaged public func removeFromLoans(at idx: Int)

    @objc(insertLoans:atIndexes:)
    @NSManaged public func insertIntoLoans(_ values: [LoanMO], at indexes: NSIndexSet)

    @objc(removeLoansAtIndexes:)
    @NSManaged public func removeFromLoans(at indexes: NSIndexSet)

    @objc(replaceObjectInLoansAtIndex:withObject:)
    @NSManaged public func replaceLoans(at idx: Int, with value: LoanMO)

    @objc(replaceLoansAtIndexes:withLoans:)
    @NSManaged public func replaceLoans(at indexes: NSIndexSet, with values: [LoanMO])

    @objc(addLoansObject:)
    @NSManaged public func addToLoans(_ value: LoanMO)

    @objc(removeLoansObject:)
    @NSManaged public func removeFromLoans(_ value: LoanMO)

    @objc(addLoans:)
    @NSManaged public func addToLoans(_ values: NSOrderedSet)

    @objc(removeLoans:)
    @NSManaged public func removeFromLoans(_ values: NSOrderedSet)

}
