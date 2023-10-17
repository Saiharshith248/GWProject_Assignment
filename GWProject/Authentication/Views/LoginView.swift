import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    // State properties for email, password, and error messages
    
    @StateObject var authManager = AuthenticationManager()
    
    @State private var email = ""
    @State private var password = ""
//    @State private var error = ""
    
    var body: some View {
        GeometryReader{geo in
            NavigationView{
                if authManager.isSignIn{
                    MainView()
                        .navigationBarBackButtonHidden()
                        .navigationBarHidden(true)
                }else{
                    
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
                            .ignoresSafeArea(.keyboard)
                            
                            Text("email *  ")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.leading,10)
                                
                            TextField("Enter email", text: $email)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .keyboardType(.emailAddress)
                                .padding(20)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                                
                            Text("password *  ")

                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.leading,10)
                            SecureField("Enter password", text: $password)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            
                            Text(authManager.error)
                                .foregroundColor(.red)
                                .padding(.leading,10)
                            
                            NavigationLink{
                                ResetPasswordView()
                                    .navigationBarBackButtonHidden()
                                    .navigationBarHidden(true)
                            }label: {
                                Text("Forgot password ?")
                            }
                            Button("Sign In") {
                                authManager.signIn(email: email, password: password)
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .tint(.blue)
                            .padding()
                            .shadow(color:.gray,radius: 0)
                            NavigationLink{
                                SignUpView()
                                    .navigationBarBackButtonHidden()
                                    .navigationBarHidden(true)
                            }label: {
                                    Text("Sign up")
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .tint(.blue)
                            .shadow(color:.gray,radius: 0)
                            Spacer(minLength: 200)
                        }
                    
                    }
                    .frame(width: geo.size.width*1, height: geo.size.height*1)
                   
                   
                }
            }
        }
        .ignoresSafeArea()
       
        .environmentObject(authManager)
      
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
