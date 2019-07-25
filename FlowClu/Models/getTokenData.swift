//
//  getTokenData.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-07-24.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseFirestore

class getTokenData {
    func getToken() {
        let db = Firestore.firestore()
        let sender = PushNotificationSender()
        //
        //        var tokenData = [Token]()
        ////        var ab: String = ""
        //
        let usersRef = db.collection("users_table")
        usersRef.getDocuments { (snapshot, error) in
            if error != nil {
                print(error)
            } else {
                for document in (snapshot?.documents)! {
                    let data = document.data()["fcmToken"] as? String
                    let token = data!
                    //                    tokenData.append(token)
                    //                    ab = token
                    print(token)
                    //                    let ftok = tokenData[0] as? String
                    //                    let sender = PushNotificationSender()
//                    sender.sendPushNotification(to: token, title: "Alert Message", body: "Someone needs your help!")
                }
            }
        }

    }
}
