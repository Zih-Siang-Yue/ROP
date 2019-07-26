//
//  ViewController.swift
//  ROP
//
//  Created by Sean.Yue on 2019/7/25.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let db: Database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test1 = UserInput(email: "Zoe@gmail.com", password: "12345678")
        let registrationResult = register(input: test1)
        switch registrationResult {
            
        case .ok(let user):
            print("user: \(user) successfully registered")
            
        case .error(let error):
            print("failed to register new user. Error: \(error)")
        }
    }
    
    func register(input: UserInput) -> Result<User, UserError> {
        return validateEmail(input)
            .bind(validatePassword)
            .bind(saveToDbWithResult)
    }
    
    private func saveToDbWithResult(input: UserInput) -> Result<User, UserError> {
        do {
            let user = try self.db.saveToDb(input)
            return .ok(user)
        }
        catch Database.DbError.duplicateKeyError {
            return .error(UserError.alreadyExist)
        }
        catch {
            return .error(UserError.unknown(cause: error))
        }
    }
    
    //MARK: validate
    private func validateEmail(_ input: UserInput) -> Result<UserInput, UserError> {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        return emailPredicate.evaluate(with: input.email) ? .ok(input) : .error(UserError.invalidEmail)
    }

    private func validatePassword(_ input: UserInput) -> Result<UserInput, UserError> {
        return input.password.count > 6 ? .ok(input) : .error(UserError.invalidPassword)
    }

}
