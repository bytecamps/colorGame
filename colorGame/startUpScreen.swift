//
//  startUpScreen.swift
//  colorGame
//
//  Created by Rosalie on 7/22/20.
//  Copyright © 2020 Rosalie. All rights reserved.
//

import SwiftUI
import Firebase

struct startUpScreen: View {
    @State var email = ""
    @State var password = ""
    @State var goToNextViewHidden = true
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Welcome to the Color Game!").font(.system(size: 40, weight: .black, design: .rounded)).multilineTextAlignment(.center).padding(.top)
                    Text("Please enter your email address to get started").font(.system(.headline, design: .rounded)).padding(.vertical)
                    TextField("John Doe", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    Text("And your password").font(.system(.headline, design: .rounded)).padding(.vertical)
                    TextField("password123", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    Button(action: {
                        self.signIn()
                    }) {
                        Text("Sign In or Sign Up").font(.headline)
                        
                    }.foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    if goToNextViewHidden == false {
                        NavigationLink(destination: ContentView(player: email)) {
                            Text("Take me to play the game!").font(.headline)
                        }.foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                    
                    
                }
                .navigationBarTitle("Sign Up", displayMode: .inline)
            }

        }
    }
    
    func signIn() {
        if email != "" {
            if password != "" {
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                  if let error = error as? NSError {
                    //Error
                    print("There was an error")
                  } else {
                    print("User signs in successfully")
                    let userInfo = Auth.auth().currentUser
                    let email = userInfo?.email
                    self.goToNextViewHidden = false
                  }
                }
            }
        }
    }
}

struct startUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        startUpScreen()
    }
}
