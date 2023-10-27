//
//  ProfilePicViewModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/25/23.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage

final class ProfilePicPickerViewModel {

    static let shared = ProfilePicPickerViewModel()
    private init() {}
    

    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let storage = Storage.storage().reference ()
        let path = "profilePics/\(userId)/image.jpeg"
        let storageRef = storage.child(path) // Make sure to use reference()

        // Check if the image already exists
        do {
            let metadata = try await storageRef.getMetadata()
            // If metadata is obtained, the image already exists, so delete it
            try await storageRef.delete()
        } catch {
            // Image does not exist or there was an error deleting it, either way, proceed with saving the new image
        }

        // Save the new image
        let returnedMetaData = try await storageRef.putDataAsync(data, metadata: meta)

        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }

        return (returnedPath, returnedName)
    }
    

}
