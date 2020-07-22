//
//  leaderboard.swift
//  colorGame
//
//  Created by Rosalie on 7/21/20.
//  Copyright © 2020 Rosalie. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct leaderboard: View {
    var db = Firestore.firestore()
    @State private var leaderboard = ["Leaderboard"]
    
    var body: some View {
        List(leaderboard, id:\.self) { Text($0) }
        .onAppear(perform: getData)
    }
    
    func getData(){
        db.collection("leaderboard")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let name = document.get("name") as! String
                        let score = document.get("score") as! Int
                        self.leaderboard.append("\(name) : \(String(score))")
                    }
                }
        }
    }
}

struct leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        leaderboard()
    }
}
