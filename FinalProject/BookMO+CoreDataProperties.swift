//
//  BookMO+CoreDataProperties.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 2017-04-06.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import Foundation
import CoreData


extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var isbn: String?
    @NSManaged public var title: String?
    @NSManaged public var cover: NSData?
    @NSManaged public var loan: LoanMO?

}
