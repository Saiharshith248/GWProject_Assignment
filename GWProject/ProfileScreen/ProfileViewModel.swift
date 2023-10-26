//
//  ProfileViewModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/4/23.
//

import Foundation
import SwiftUI
import PhotosUI

func saveUserDetails(userId : String, userModel : UserModel, pic : PhotosPickerItem){
    let authenticationManger = AuthenticationManager()
    let signUpModel = SighUpModel(userid: userId, firstname: userModel.firstname, lastname: userModel.lastname, email: userModel.email, phone: userModel.phone, address: userModel.address)
    authenticationManger.storeUserDetails(uid: userId, allData: signUpModel)
    saveProfileImg(item: pic, userId: userId)
    
}
func saveProfileImg(item : PhotosPickerItem, userId : String){
    Task{
        guard let data = try await item.loadTransferable(type: Data.self) else { return }
        let (path, name) = try await ProfilePicPickerViewModel.shared.saveImage(data: data, userId: userId)
        print("SUCCESS")
        print(path)
        print(name)
    }
}
