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
            
        case .success(let user):
            print("user: \(user) successfully registered")
            
        case .failure(let error):
            print("failed to register new user. Error: \(error)")
        }
    }
    
    func register(input: UserInput) -> Result<User, UserError> {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        
        guard emailPredicate.evaluate(with: input.email) else {
            return .failure(UserError.invalidEmail)
        }
        
        guard input.password.count > 6 else {
            return .failure(UserError.invalidPassword)
        }
        
        do {
            let user = try db.saveToDb(input)
            return .success(user)
        }
        catch Database.DbError.duplicateKeyError {
            return .failure(UserError.alreadyExist)
        }
        catch {
            return .failure(UserError.unknown(cause: error))
        }
    }


}

