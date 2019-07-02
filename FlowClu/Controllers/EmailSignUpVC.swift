//
//  EmailSignUpVC.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-07.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class EmailSignUpVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordsUnmatchLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func signUpButtonWasPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Hello  Coders", message: "Visit www.simplifiedios.net to learn xcode", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        
        
        guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else {
                present(alertController, animated: true, completion: nil)
                return
        }
        
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                debugPrint(error)
                return
            }
            print("Successfully registered new user")
            self.activityIndicator.stopAnimating()
            let uid = Auth.auth().currentUser?.uid
        }
        
        
        
    }
}
