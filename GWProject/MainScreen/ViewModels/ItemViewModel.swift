//
//  ItemViewModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/18/23.
//

import Foundation
import Firebase
import FirebaseFirestore
class ItemViewModel: ObservableObject {
    func addItem(title: String, description: String, category: String, picktype: String, userId: String, expireDate : Date) {
        let db = Firestore.firestore()
        
        // Generate a unique ID
        let uniqueID = UUID().uuidString
        
        // Define the item data, including the unique ID as "itemid"
        let itemDetails: [String: Any] = [
            "userid": userId,
            "itemid": uniqueID, // Include the unique ID as "itemid"
            "title": title,
            "description": description,
            "givingType": picktype,
            "itemCategory": category,
            "expiresOn" : expireDate,
            "postedOn" : Date(),
        ]
        
        let ref = db.collection("item")
        
        // Create the document with the unique ID
        let newDocumentReference = ref.document(uniqueID)
        newDocumentReference.setData(itemDetails) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(uniqueID)")
            }
        }
    }
}
