//
//  FirebaseSignOut.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-10.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import Foundation
import FirebaseAuth

func signOut() -> Bool{
    do{
        try Auth.auth().signOut()
        return true
    }catch{
        return false
    }
}
