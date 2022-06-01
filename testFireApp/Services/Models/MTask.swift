//
//  Task.swift
//  testFireApp
//
//  Created by Глеб Писарев on 25.04.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

struct MTask {
    var title = ""
    var price = ""
    var place = ""
    var more = ""
    var ref: DatabaseReference?
    
    init () { }
    
    init (snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.title = snapshotValue["title"] as! String
        self.price = snapshotValue["price"] as! String
        self.place = snapshotValue["place"] as! String
        self.more = snapshotValue["more"] as! String
    }
    
    func convertToDictionary() -> Any {
        return ["title": title, "price": price, "place": place, "more": more]
    }
    
}

