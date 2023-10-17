import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager : AuthenticationManager
    @State var userData : UserModel = .init(firstname: .init(), lastname: .init(), email: .init(), phone: .init(), address: .init())
    @State var sample = "Harshith"
    @State var editOn : Bool = false
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [.white, .gray]), center: .center, startRadius: 2, endRadius: 650)
                    VStack{
                        HStack{
                            NavigationLink(destination: MainView()) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                    .padding(.leading,20)
                                    .fontWeight(.bold)
                            }
                            .isDetailLink(false)
                            Spacer()
                            Text("Profile")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .padding(.trailing,25)
                            
                            Spacer()
                        }
                        .ignoresSafeArea(.keyboard)
                        .frame(width: geo.size.width*1, height: geo.size.height*0.07)
                        .background(.opacity(0.05))
                        .background(RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650))
                        Spacer()
                        VStack{
                            VStack{
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .foregroundColor(.black)
                            }
                            .frame(width: 50,height: 50,alignment: .center)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                            Section{
                                Text("first name*")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,10)
                                    .fontWeight(.medium)
                                CommonDataFieldView(text: $userData.firstname)
                                Divider()
                                    .padding(.bottom,10)
                                
                                
                                
                                
                                Text("Last name ")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,10)
                                    .fontWeight(.medium)
                                CommonDataFieldView(text: $userData.lastname)
                                Divider()
                                    .padding(.bottom,10)
                                Text("Email")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,10)
                                    .fontWeight(.medium)
                                CommonDataFieldView(text: $userData.email)
                            }
                            Section{
                                Divider()
                                    .padding(.bottom,10)
                                Text("Phone")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,10)
                                    .fontWeight(.medium)
                                CommonDataFieldView(text: $userData.phone)
                                Divider()
                                    .padding(.bottom,10)
                                Text("Address")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,10)
                                    .fontWeight(.medium)
                                CommonDataFieldView(text: $userData.address)
                                Divider()
                                    .padding(.bottom,10)
                            }
                            Spacer()
                            
                            HStack{
                                Button{
                                    saveUserDetails(userId: authManager.currUserId, userModel: userData)
                                }label: {
                                    HStack{
                                        Image(systemName: "bookmark.fill")
                                        Text("Save")
                                    }
                                }
                                .foregroundColor(.white)
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.roundedRectangle)
                                .background(Color("bgcolor"))
                                .cornerRadius(10)
                                Spacer()
                                Button{
                                    
                                }label: {
                                    HStack{
                                        Image(systemName: "checkmark.seal.fill")
                                        Text("Verify")
                                    }
                                }
                                .foregroundColor(.white)
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.roundedRectangle)
                                .background(Color("bgcolor"))
                                .cornerRadius(10)
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                    
                        }
                        .frame(maxWidth: geo.size.width * 1, maxHeight: .infinity)
                        
                        
                        .onAppear {
                            authManager.getCurrUserData(uid: authManager.currUserId) { data in
                                if let userData = data {
                                    self.userData = userData
                                } else {
                                    self.userData = UserModel(firstname: "NA", lastname: "NA", email: "NA", phone: "NA", address: "NA")
                                }
                            }
                        }
                        
                    }
                    .padding(0)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }
        
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
