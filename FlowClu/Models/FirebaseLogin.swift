//
//  FirebaseLogin.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-10.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import Foundation
import FirebaseAuth

func login(withEmail email: String, password: String, _ callback: ((Error?) -> ())? = nil){
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if let e = error{
            callback?(e)
            return
        }
        callback?(nil)
    }
}
