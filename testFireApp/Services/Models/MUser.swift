//
//  user.swift
//  testFireApp
//
//  Created by Глеб Писарев on 27.04.2022.
//

import Foundation
import FirebaseDatabase

struct MUser {
    let username: String
    let email: String
    let uid: String
    
    init(username: String, email: String, uid: String) {
        self.username = username
        self.email = email
        self.uid = uid
    }
    
}
