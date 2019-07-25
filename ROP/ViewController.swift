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
        let (user, error) = register(input: test1)
        if (error != nil) {
            print("User register unsuccessfully: \(error!)")
        }
        else {
            print("user: \(String(describing: user!))")
        }
//        guard let err = error else {
//            print("User register unsuccessfully: \(err)")
//            return
//        }
//        print("user: \(String(describing: user))")
    }
    
    func register(input: UserInput) -> (User?, UserError?) {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        guard emailPredicate.evaluate(with: input.email) else {
            return (nil, UserError.invalidEmail)
        }
        
        guard input.password.count > 6 else {
            return (nil, UserError.invalidPassword)
        }
        
        do {
            let user = try db.saveToDb(input)
            return (user, nil)
        }
        catch Database.DbError.duplicateKeyError {
            return (nil, UserError.alreadyExist)
        }
        catch {
            return (nil, UserError.unknown(cause: error))
        }
    }


}

