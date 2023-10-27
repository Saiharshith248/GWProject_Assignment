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
import FirebaseStorage
@MainActor


struct MainView: View {
    @State var isSignout = false
    @State var menuClick = false
    @EnvironmentObject var authManager : AuthenticationManager
    @State var userData : UserModel = .init(firstname: .init(), lastname: .init(), email: .init(), phone: .init(), address: .init())
    
    @StateObject var itemViewModel = ItemViewModel()
    @State var itemModel : ItemModel = .init( title: .init(), description: .init(), givingType: .init(), itemCategory: .init(), userId: .init(), postedOn: .init(),expiresOn: .init())
    
    @State private var getsavedProfilePic : UIImage?
    
    @State var sample : String = ""
    @State var addItemButton:Bool = false
    
    @State var selectedItems : [PhotosPickerItem] = []
    
    var body: some View {
        GeometryReader{ geo in
            if isSignout{
                LoginView()
                    .navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
                
            }else{
                NavigationView {
                    ZStack{
                        Color("bgcolor")
                        VStack{
                            Spacer()
                            HStack{
                            
                                if !menuClick{
                                    Button{
                                        
                                        menuClick.toggle()
                                        addItemButton = false
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
                                Button {
                                    addItemButton.toggle()
                                    menuClick = false
                                } label: {
                                    if addItemButton{
                                        Text("X")
                                            .foregroundColor(.white)
                                    }else{
                                        Text("Add button")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(.top,30)
//                            .position(x: UIScreen.main.bounds.width / 2, y:30)
                            .frame(height: geo.size.height * 0.1)
                            .background(RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650))
                            
                            
                            VStack{
                                
                            }
                            .frame(width: geo.size.width * 1,height: geo.size.height * 0.9)
                            .background(.white)
                            
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
                                    .animation(.easeInOut)
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
                    Button{
                        addItemButton = false
                    }label: {
                        Image("close")
                            .padding(.leading,15)
                            .foregroundColor(.white)
                    }
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
                               .background(.white)
                    HStack {
                        ForEach(selectedItems, id: \.self) { item in
                            ImageView(item: item)
                        }
                    }

                    PhotosPicker(selection: $selectedItems, matching: .images, photoLibrary: .shared()) {
                        Text("Select imgs")
                            .foregroundColor(.white)
                    
                    }
                    
                    
                    Button {
                        itemViewModel.addItem(title: itemModel.title , description: itemModel.description, category: itemModel.itemCategory, picktype: itemModel.givingType, userId: authManager.currUserId, expireDate: itemModel.expiresOn, selectedItems: selectedItems)
                        
                        addItemButton = true
                    
                    } label: {
                        Text("add")
                    }
                    .foregroundColor(.black)
                    .background(.white)
                }
                .frame(width: geo.size.width * 1,  alignment: .leading)
            }
            .offset(x: addItemButton ? 0 : -geo.size.width * 0.8, y: geo.size.height * 0.12)
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
                            
                                if let image = getsavedProfilePic {
                                    Image(uiImage: image)
                                        .resizable()
                                        .foregroundColor(.white)
                                    
                                }else{
                                    Image(systemName: "person")
                                        .resizable()
                                        .foregroundColor(.white)
                                }
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
                        .onAppear{
                            getProfilePic(userId: authManager.currUserId)
                        }
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
                .frame(width: geo.size.width * 1 ,height: geo.size.height * 1  ,alignment: .leading)
                
                
            }
            .offset(x: menuClick ? 0 : -geo.size.width * 0.8, y: geo.size.height * 0.12)
            
        }
        
    }
    
    
    func getProfilePic(userId : String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let folderPath = "profilePics/\(userId)"
        let fileName = "image.jpeg"
        let fileRef = storageRef.child(folderPath).child(fileName)
        
        fileRef.getData(maxSize: 1 * 3024 * 3024) { data, error in
            if let error = error {
                print("Error downloading file: \(error.localizedDescription)")
            } else {
                if let imageData = data {
                    getsavedProfilePic = UIImage(data: imageData)
                }
            }
        }
    }
    
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

