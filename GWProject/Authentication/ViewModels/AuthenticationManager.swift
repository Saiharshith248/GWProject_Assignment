//
//  AuthenticationManager.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/31/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthenticationManager : ObservableObject{
    
    @Published var currUserId : String = ""
    @Published var isSignIn : Bool = false
    @Published var isSignedUp : Bool = false
    @Published var signUpModel = SighUpModel(userid: .init(), firstname: .init(), lastname: .init(), email: .init(), phone: .init(), address: .init())
    
    @Published var error : String = ""
    
    
    func signIn(email : String, password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = "Invalid Credentials"
                print(error)
                
            } else {
                self.error = ""
                print("Successfully signed IN")
                self.isSignIn = true
                self.currUserId = (result?.user.uid ?? "None")!
                print("--------")
                print(self.currUserId)
            }
        }
    }
    
    
    
    func signUp(allData : SighUpModel, password : String) {
        print("insignup")
        Auth.auth().createUser(withEmail: allData.email, password: password) { authResult, error in
            if error != nil {
                self.error = "InCorrect Details"
            } else {
                self.error = ""
                let user = authResult?.user
                if let user = user {
                    self.storeUserDetails(uid: user.uid, allData: allData)
                    
                }
            }
        }
    }
    
    func storeUserDetails(uid: String, allData : SighUpModel) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        let userDetails = [
            "userid":uid,
            "firstName": allData.firstname,
            "lastName": allData.lastname,
            "email": allData.email,
            "phone": allData.phone,
            "address": allData.address,
        ]
        
        userRef.setData(userDetails) { error in
            if let error = error {
                print("Error storing user details: \(error.localizedDescription)")
            } else {
                print("User details stored successfully")
                self.isSignedUp = true
                
            }
        }
    }

    func resetPassword(email : String){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("Reset email sent")
            }
            
        }
    }
    
    func logOut() {
        do{
            try Auth.auth().signOut()
            self.currUserId = .init()
            print("---")
            print(self.currUserId)
            print("------")
        }catch{
            print("Error Occured")
        }
        print("Successfully signed Out")
        
    }
    
//    func getCurrUserData(uid : String, completion: @escaping (UserModel?) -> Void) -> UserModel{
//        var userData = UserModel(firstname: "NA", lastname: "NA", email: "NA", phone: "NA", address: "NA")
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(uid)
//        userRef.getDocument { (document, error) in
//            if let error = error {
//                print("Error retrieving data: \(error)")
//                completion(nil)
//            } else {
//                if let document = document, document.exists {
//                    let data = document.data()
//
//                    userData.email = data!["email"] as! String
//                    userData.address = data!["address"] as! String
//                    userData.firstname = data!["firstName"] as! String
//                    userData.lastname = data!["lastName"] as! String
//                    userData.phone = data!["phone"] as! String
//                    completion(userData)
//
//
//                }else {
//                    print("Document does not exist")
//                    completion(nil)
//                }
//            }
//        }
//        return userData
//    }
 
    func getCurrUserData(uid: String, completion: @escaping (UserModel?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error retrieving data: \(error)")
                completion(nil)
            } else {
                if let document = document, document.exists {
                    let data = document.data()
                    var userData = UserModel(firstname: "NA", lastname: "NA", email: "NA", phone: "NA", address: "NA")

                    userData.email = data!["email"] as! String
                    userData.address = data!["address"] as! String
                    userData.firstname = data!["firstName"] as! String
                    userData.lastname = data!["lastName"] as! String
                    userData.phone = data!["phone"] as! String

                    completion(userData)
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
    }

    
}
