//
//  CommonDataFieldView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/4/23.
//

import SwiftUI

struct CommonDataFieldView: View {
    @State var editOn : Bool = false
    @Binding var text : String
    var body: some View {
        HStack{
            if editOn{
                TextField("Enter email", text: $text)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.emailAddress)
                    .padding(10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    
            }else{
                Text(text)
                    .frame(alignment: .leading)
                    .keyboardType(.emailAddress)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
                    .cornerRadius(10)

            }

            Spacer()
            Button {
                editOn.toggle()
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.black)
            }
            .padding(.trailing,10)

        }
    }
}
//
//struct CommonDataFieldView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CommonDataFieldView()
//    }
//}
