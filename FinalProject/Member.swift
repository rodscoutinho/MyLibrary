//
//  Member.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 13/02/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import Foundation

class Member: CustomStringConvertible {
    private static var internalId: Int = 0
    public private(set) var id: Int
    var name: String
    var phone: String
    var address: String
    var email: String
    
    init(name: String, phone: String, address: String, email: String) {
        Member.internalId += 1
        self.id = Member.internalId
        self.name = name
        self.phone = phone
        self.address = address
        self.email = email
    }
    
    public var description: String {
        get {
            return "Id: \(self.id)\nName: \(self.name)\nPhone: \(self.phone)\nAddress: \(self.address)\nEmail: \(email)\n"
        }
    }
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func setPhone(_ phone: String) {
        self.phone = phone
    }
    
    func setAddress(_ address: String) {
        self.address = address
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
}

extension Member: Hashable {
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
}

extension Member: Equatable { }

func ==(lhs: Member, rhs: Member) -> Bool {
    return lhs === rhs
}
