//
//  SignUpView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/22/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State var password = ""
    
    @State var signUpModel = SighUpModel(userid: .init(), firstname: .init(), lastname: .init(), email: .init(), phone: .init(), address: .init())
    
    @State var error = ""
    
    @EnvironmentObject var authManager : AuthenticationManager
    
    var body: some View {
        GeometryReader{geo in
            NavigationView {
                
                
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650)
                    
                    if authManager.isSignedUp{
                        LoginView()
                            .navigationBarBackButtonHidden()
                            .navigationBarHidden(true)
                    }
                   
                    else{
                        VStack{
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.bottom,40)
                                .padding(.leading,20)
                                .fontWeight(.bold)
                            
                            Section{
                                Text("Firstname *  ")
                                    .foregroundColor(.white)
                                    .padding(.leading,15)
                                TextField("Enter ", text: $signUpModel.firstname)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .keyboardType(.emailAddress)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                
                                Text("Lastname *  ")
                                    .foregroundColor(.white)
                                    .padding(.leading,15)
                                TextField("Enter ", text: $signUpModel.lastname)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .keyboardType(.emailAddress)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                Text("Email *  ")
                                    .padding(.leading,15)
                                    .foregroundColor(.white)
                                TextField("Enter ", text: $signUpModel.email)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .keyboardType(.emailAddress)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Section{
                                Text("Phone *  ")
                                    .foregroundColor(.white)
                                    .padding(.leading,15)
                                TextField("Enter ", text: $signUpModel.phone)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .keyboardType(.emailAddress)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                Text("Address *  ")
                                    .padding(.leading,15)
                                    .foregroundColor(.white)
                                
                                TextField("Enter ", text: $signUpModel.address)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .keyboardType(.emailAddress)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                
                                Text("Password *  ")
                                    .foregroundColor(.white)
                                    .padding(.leading,15)
                                SecureField("Enter password", text: $password)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                                Text(authManager.error)
                                    .foregroundColor(.red)
                                    .padding(.leading,10)
                                    
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            
                            
                            HStack{
                                if !authManager.isSignedUp{
                                    Button("Sign Up") {
                                        authManager.signUp(allData: signUpModel, password: password)
                                    }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.white)
                                    .tint(.blue)
                                    .padding()
                                    .shadow(color:.gray,radius: 0)
                                }else{
                                    Text("Already signedUp")
                                }
                                NavigationLink{
                                    LoginView()
                                        .navigationBarBackButtonHidden()
                                        .navigationBarHidden(true)
                                }label: {
                                    Text("Sign In")
                                }
                                .buttonStyle(.bordered)
                                .foregroundColor(.white)
                                .tint(.blue)
                                .padding()
                                .shadow(color:.gray,radius: 0)
                            }
                            .padding(.top,40)
                            
                        }
                        .padding(0)
                    }
                    
                }
                .frame(width: geo.size.width*1, height: geo.size.height*1.1)
                
            }
            .navigationBarHidden(true)
            
        }
        
        .ignoresSafeArea()
    }
    
}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
