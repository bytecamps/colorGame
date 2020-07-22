//
//  ContentView.swift
//  colorGame
//
//  Created by Rosalie on 7/19/20.
//  Copyright © 2020 Rosalie. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    @State var text = "Start"
    @State var color = Color("lightGreen")
    @State var colorString = "lightGreen"
    @State var listOfColors = [Color.red : "red", Color.green : "green", Color.blue : "blue", Color.black : "black", Color.orange : "orange", Color.pink : "pink", Color.purple : "purple",
        Color.yellow : "yellow"]
    @State var colors = ["red", "green", "blue", "black", "orange", "pink", "purple", "yellow"]
    @State var score = 0
    @State var timeLeft = 15
    @State var buttonDisabled = false
    
    @State var player = "Frank"
    
    var db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink (destination: leaderboard()) {
                        HStack {
                            Text("Leaderboard")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Image(systemName: "text.bubble").font(.system(size: 20))
                        }
                    }.foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    
                    NavigationLink (destination: InstructionsView()) {
                        HStack {
                            Text("Instructions")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Image(systemName: "info.circle").font(.system(size: 20))
                        }
                    }.foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    
                }.padding(.top, 20)
                
                Spacer()
                Text("Score: \(score)")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color(red: 0.902, green: 0.224, blue: 0.275))
                    .padding(.bottom, 30.0)
                Text("Time: \(timeLeft)")
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color(red: 0.902, green: 0.224, blue: 0.275))
                Spacer()
                Text(text).font(.system(size: 60, weight: .black, design: .rounded)).foregroundColor(color)
                    .onTapGesture {
                        self.startGame()
                }
                Spacer()
                VStack (spacing: 20){
                    HStack (spacing: 20) {
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "red")
                        }) {
                            Text("Red")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                        
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "green")
                        }) {
                            Text("Green")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                    }
                    
                    HStack (spacing: 20) {
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "blue")
                        }) {
                            Text("Blue")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                        
                        Button(action: {
                            print("button pressed")
                            self.checkButtonPressed(colorOfButtonPress: "black")
                        }) {
                            Text("Black")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                    }
                    
                    HStack (spacing: 20) {
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "orange")
                        }) {
                            Text("Orange")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                        
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "pink")
                        }) {
                            Text("Pink")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                    }
                    
                    HStack (spacing: 20) {
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "purple")
                        }) {
                            Text("Purple")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                        
                        Button(action: {
                            self.checkButtonPressed(colorOfButtonPress: "yellow")
                        }) {
                            Text("Yellow")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(20)
                        .disabled(buttonDisabled)
                    }
                }.padding(.horizontal, 20)
                
//                .navigationBarItems(
//                    leading: Text("Welcome to the Color Game").font(.system(size: 25, weight: .bold, design: .rounded)),
//
//                    trailing:
//                    NavigationLink(destination: InstructionsView()) {
//                        Image(systemName: "info.circle").font(.system(size: 25))
//                    }
//                )
                    .navigationBarTitle("Welcome to the Color Game", displayMode: .inline)
            }
        }
    }
    
    func startGame() {
        if timeLeft == 15 {
            buttonDisabled = false
            countDown()
            putInNewColor()
            
        }
        
        if timeLeft == 0 {
            text = "Start"
            timeLeft = 15
            score = 0
        }
    }
    
    func putInNewColor() {
        color = listOfColors.keys.randomElement()!
        colorString = listOfColors[color]!
        if let index = colors.firstIndex(of: colorString) {
            colors.remove(at: index)
            text = colors.randomElement()!
            colors.append(colorString)
            print("color String", colorString)
            print("text", text)
        }
        
    }
    
    func checkButtonPressed(colorOfButtonPress: String) {
        print("Checking now")
        if colorOfButtonPress == colorString {
            print("upping score")
            score += 1
            self.putInNewColor()
        }
        
    }
    
    func countDown() {
        if timeLeft > 0 {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.timeLeft -= 1
                self.countDown()
            }
        }
        else {
            text = "Start Over"
            buttonDisabled = true
            
            let docRef = db.collection("leaderboard").document(player)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    
                    if var userHighScore = document.get("score") as? Int  {
                        print("userHighScore", userHighScore)
                        if self.score > userHighScore {
                            self.uploadScoreToFirebase()
                        }
                    }
                    
                    
                } else {
                    print("Document does not exist")
                    self.createFirebaseDocument()
                }
            }
        }
    }
    
    func uploadScoreToFirebase() {
        // Upload to Firebase
        db.collection("leaderboard").document(player).updateData([
            "name" : player,
            "score" : score
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func createFirebaseDocument() {
        // Upload to Firebase
        db.collection("leaderboard").document(player).setData([
            "name" : player,
            "score" : score
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
