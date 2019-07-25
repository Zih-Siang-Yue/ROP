//
//  Database.swift
//  ROP
//
//  Created by Sean.Yue on 2019/7/25.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

import Foundation

class Database: NSObject {

    var userDb = [String: User]()
    
    enum DbError: Error {
        case duplicateKeyError
    }
    
    public func saveToDb(_ input: UserInput) throws -> User {
        if userDb[input.email] != nil {
            print("user \(input.email) already exists");
            throw DbError.duplicateKeyError
        }
        
        let newUser = User(email: input.email)
        userDb[input.email] = newUser
        print("user saved: \(newUser)")
        return newUser
    }
}

