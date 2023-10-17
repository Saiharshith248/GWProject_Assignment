//
//  RewardView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/3/23.
//

import SwiftUI

struct RewardView: View {
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
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
                        Text("Rewards")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .padding(.trailing,25)

                        Spacer()
                    }
                    .frame(width: geo.size.width*1, height: geo.size.height*0.07)
                    .background(.opacity(0.05))
                    .background(RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650))
                    Spacer()
                    
                }
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
