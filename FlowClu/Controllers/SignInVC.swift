//
//  SignInVC.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-07.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func signInButtonWasPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) {user, error in
//            guard let strongSelf = self else { return }
            
            if let error = error {
                debugPrint(error)
                return
            }
            print("User Successfully logged in")
            self.activityIndicator.stopAnimating()
           
        }
        
        let currentUser = Auth.auth().currentUser
        
        if ( currentUser == nil) {
            return
        } else {
            
//            self.performSegue(withIdentifier: "signInToTabBar", sender: self)
            
            
        }
        
        
    }
    
}
