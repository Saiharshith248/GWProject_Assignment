////
////  ItemPhotoPickerViewModel.swift
////  GWProject
////
////  Created by Sai Harshith Tanguturi on 10/24/23.
////
//
import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseStorage

final class ItemPhotoPickerViewModel {
    
    static let shared = ItemPhotoPickerViewModel()
    private init() {}
    private let storage = Storage.storage().reference()
    
    func saveImages(dataArray: [Data], itemId: String) async throws -> [(path: String, name: String)] {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        var uploadedImages: [(path: String, name: String)] = []
        
        for (index, data) in dataArray.enumerated() {
            let path = "itemImages/\(itemId)/image\(index).jpeg"
            
            let returnedMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
            
            guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
                throw URLError(.badServerResponse)
            }
            
            uploadedImages.append((returnedPath, returnedName))
        }
        
        return uploadedImages
    }
}
