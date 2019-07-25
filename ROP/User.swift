//
//  User.swift
//  ROP
//
//  Created by Sean.Yue on 2019/7/25.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

import Foundation

struct UserInput {
    let email: String
    let password: String
}

struct User {
    let id = UUID.init()
    let email: String
}

enum UserError: Error {
    case invalidEmail, invalidPassword, alreadyExist
    case unknown(cause: Error)
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return "{ id: \(id), email: \(email) }"
    }
}
