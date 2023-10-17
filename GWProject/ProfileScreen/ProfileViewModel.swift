//
//  ProfileViewModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/4/23.
//

import Foundation

func saveUserDetails(userId : String, userModel : UserModel){
    let authenticationManger = AuthenticationManager()
    let signUpModel = SighUpModel(userid: userId, firstname: userModel.firstname, lastname: userModel.lastname, email: userModel.email, phone: userModel.phone, address: userModel.address)
    authenticationManger.storeUserDetails(uid: userId, allData: signUpModel)
}
