//
//  ItemViewModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/18/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseStorage

class ItemViewModel: ObservableObject {
    
    var itemId : String = ""
    @MainActor
    func addItem(title: String, description: String, category: String, picktype: String, userId: String, expireDate : Date, selectedItems: [PhotosPickerItem]) {
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
                self.itemId = uniqueID
                self.saveProfileImages(items: selectedItems)
                
            }
        }
    }
    
    func saveProfileImages(items: [PhotosPickerItem]) {
            Task {
                var imageDataArray: [Data] = []
                
                for item in items {
                    if let data = try await item.loadTransferable(type: Data.self) {
                        imageDataArray.append(data)
                    }
                }
                
                if !imageDataArray.isEmpty {
                    do {
                        let uploadedImages = try await ItemPhotoPickerViewModel.shared.saveImages(dataArray: imageDataArray, itemId: self.itemId)
                        for (index, image) in uploadedImages.enumerated() {
                            print("Image \(index) uploaded successfully!")
                            print("Path: \(image.path), Name: \(image.name)")
                        }
                    } catch {
                        print("Error uploading images: \(error.localizedDescription)")
                    }
                }
            }
        }
    
}
