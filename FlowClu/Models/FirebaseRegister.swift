//
//  FirebaseRegister.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-10.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import Foundation
import FirebaseAuth

func createUser(name: String, email: String, password: String, confirmPassword: String, _ callback: ((Error?) -> ())? = nil){
    if password == confirmPassword {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error{
                callback?(e)
                return
            }
            callback?(nil)
        }
    } else {
//        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        self.present(alert, animated: true, completion: nil)
        print("Passwords do not match!")
    }
}
