//
//  HomeStoryboardVC.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-12.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeStoryboardVC: UIViewController {

    @IBOutlet weak var settingsButtonClicked: UIButton!
    @IBOutlet weak var nextPeriodDetailsHeaderLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var randomPostLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = (Auth.auth().currentUser?.uid)!
        print(userID)
        tokenData = []
        
        // PN Firebase Start
        
        // Saving token to FC DB
        let pushManager = PushNotificationManager(userID: userID)
        pushManager.registerForPushNotifications()
        
        // getting tokens
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if error != nil {
                print(error)
            } else {
                for document in (snapshot?.documents)! {
                    if let name = document.data()["fcmToken"] as? String {
                        print(name)
                        print("Getting data working...")
                        
                        
                        tokenData.append(name)
                        
                    }
                }
                print("Out pf funcrions")
                print(tokenData)
//                sender.sendPushNotification(to: tokenData[0], title: "Chl Peaa", body: "Kiddan praa")
                
            }
        }
        print("Out pf funcrions")
        print(tokenData)
        
        
        //PN Firebase End

    }
    
   
    
    
    @IBAction func addPeriodButtonClicked(_ sender: Any) {
    }
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
