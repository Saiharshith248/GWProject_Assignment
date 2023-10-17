//
//  ResetPasswordView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/23/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ResetPasswordView: View {
    @State var resetemail = ""
    @EnvironmentObject var authManager : AuthenticationManager
    var body: some View {
        GeometryReader{geo in
            NavigationView{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650)
                    
                    
                    VStack {
                        HStack{
                            Image("bgimage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                            VStack{
                                Text("Give Away")
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                                    .font(.system(size: 43))
                                    .padding(.bottom,2)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                                    .shadow(color:.white, radius: 20)
                                Text("Be Sharing - Be Happy")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,25)
                                    .font(.system(size: 18))
                                
                            }
                            
                        }
                        .frame(width: geo.size.width * 1, height: geo.size.height*0.45)

                        TextField("Enter email", text: $resetemail)
                            .frame(maxWidth: .infinity)
                            .keyboardType(.emailAddress)
                            .padding(20)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                        
                        Button("Send Reset Email") {
                            authManager.resetPassword(email: resetemail)
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                        .tint(.blue)
                        .padding()
                        .shadow(color:.gray,radius: 0)
                        NavigationLink{
                            LoginView()
                                .navigationBarBackButtonHidden()
                        }label: {
                            Text("Login")
                        }
                        Spacer()
                    }
                    .frame(width: geo.size.width*1, height: geo.size.height*1.1)
                }
                
            }
            
        }
        .ignoresSafeArea()
    }
    
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
