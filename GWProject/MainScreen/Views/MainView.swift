//
//  MainView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/23/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import PhotosUI

struct MainView: View {
    @State var isSignout = false
    @State var menuClick = false
    @EnvironmentObject var authManager : AuthenticationManager
    @State var userData : UserModel = .init(firstname: .init(), lastname: .init(), email: .init(), phone: .init(), address: .init())
    //    let menuOptions = ["Profile", "Sells & Buys", "Contact", "LogOut"]
    
    @StateObject var itemViewModel = ItemViewModel()
    @State var itemModel : ItemModel = .init( title: .init(), description: .init(), givingType: .init(), itemCategory: .init(), userId: .init(), postedOn: .init(),expiresOn: .init())
    
    
    @State var sample : String = ""
    @State var addItemButton:Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            if isSignout{
                LoginView()
                    .navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
                
            }else{
                NavigationView {
                    VStack{
                        HStack{
                            if !menuClick{
                                Button{
                                    menuClick.toggle()
                                }label: {
                                    Image("menu")
                                        .padding(.leading,15)
                                }
                            }else{
                                Button{
                                    menuClick.toggle()
                                }label: {
                                    Image("close")
                                        .padding(.leading,15)
                                }
                            }
                            Spacer()
                            Text("GiveAway")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        .frame(width: geo.size.width*1, height: geo.size.height*0.07)
                        
                        .background(RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650))
                        Spacer()
                        
                        Button {
                            addItemButton.toggle()
                        } label: {
                            if addItemButton{
                                Text("X")
                                    .foregroundColor(.black)
                            }else{
                                Text("Add button")
                                    .foregroundColor(.black)
                            }
                        }
                        if addItemButton {
                            withAnimation{
                                
                                self.AddItemView
                                    .transition(.move(edge: .trailing))
                                    .animation(.easeIn)

                            }
                        }
                        
                        
                        Spacer()
                        if menuClick {
                            withAnimation{
                                
                                self.menuSliderView
                                    .transition(.move(edge: .leading))
                                    .animation(.easeIn)
                                    .onAppear{
                                        authManager.getCurrUserData(uid: authManager.currUserId) { data in
                                            if let userData = data {
                                                self.userData = userData
                                            } else {
                                                self.userData = UserModel(firstname: "NA", lastname: "NA", email: "NA", phone: "NA", address: "NA")
                                            }
                                        }
                                    }
                            }
                        }
                        
                        
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                
            }
            
            
        }
        .ignoresSafeArea()
        
    }
    
    private var AddItemView: some View {
        GeometryReader { geo in
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650)
                VStack {
                    TextField("Title", text: $itemModel.title)
                        .foregroundColor(.black)
                        .background(.white)
                    TextField("Description", text: $itemModel.description)
                        .foregroundColor(.black)
                        .background(.white)
                    TextField("Category", text: $itemModel.itemCategory)
                        .foregroundColor(.black)
                        .background(.white)
                    TextField("Pick Type", text: $itemModel.givingType)
                        .foregroundColor(.black)
                        .background(.white)
                    DatePicker("Expiry Date", selection: $itemModel.expiresOn, in: Date()..., displayedComponents: .date)
                               .labelsHidden()
                               .foregroundColor(.white)
                               .background(.black)
                    
                    
                    
                    
                    Button {
                        itemViewModel.addItem(title: itemModel.title , description: itemModel.description, category: itemModel.itemCategory, picktype: itemModel.givingType, userId: authManager.currUserId, expireDate: itemModel.expiresOn)
                    } label: {
                        Text("add")
                    }
                    .foregroundColor(.black)
                    .background(.white)
                }
                .frame(width: geo.size.width * 1, height: geo.size.height * 1.2, alignment: .leading)
            }
        }
    }

    
    
    private var menuSliderView: some View {
        
        GeometryReader { geo in
            ZStack{
                RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650)
                VStack {
                    
                    ScrollView{
                        HStack{
                            Spacer(minLength: 5)
                            VStack{
                                Image(systemName: "person")
                                    .resizable()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 90,height: 90,alignment: .leading)
                            Spacer()
                            VStack{
                                Text(self.userData.firstname)
                                Text(self.userData.lastname)
                            }
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            Spacer()
                        }
                        .frame(width: geo.size.width * 1, height: geo.size.height * 0.2)
                        .background(.opacity(0.05))
                        NavigationLink(destination: ProfileView()) {
                            HStack{
                                Image(systemName: "person")
                                Text("Profile")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                            
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        
                        
                        NavigationLink(destination: GiveawayView()) {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.right")
                                Text("Give Aways")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                            
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        NavigationLink(destination: PickupView()) {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.left")
                                Text("Pick Ups")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                            
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        NavigationLink(destination: RewardView()) {
                            HStack{
                                Image(systemName: "dollarsign.circle")
                                Text("Rewards")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                            
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        NavigationLink(destination: SettingView()) {
                            HStack{
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        NavigationLink(destination: ContactView()) {
                            HStack{
                                Image(systemName: "phone")
                                Text("Contact")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                        }
                        .isDetailLink(false)
                        .navigationBarHidden(true)
                        
                        Button{
                            isSignout = true
                            authManager.logOut()
                        }label: {
                            HStack{
                                Image(systemName: "square.and.arrow.up")
                                Text("Logout")
                            }
                            .padding(.leading,25)
                            .frame(width: geo.size.width * 1, height: geo.size.height * 0.1,alignment: .leading)
                            .modifier(MenuOptionViewModifier())
                        }
                        
                    }
                    
                    
                    
                }
                .frame(width: geo.size.width * 1,height: geo.size.height*1.2 ,alignment: .leading)
                
                
            }
        }
        
    }
        
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


