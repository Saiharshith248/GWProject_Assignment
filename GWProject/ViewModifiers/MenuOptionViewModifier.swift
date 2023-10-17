//
//  MenuOptionViewModifier.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 9/26/23.
//

import Foundation
import SwiftUI

struct MenuOptionViewModifier: ViewModifier{
    func body(content: Content) -> some View {
        
        content
//            .background(RadialGradient(gradient: Gradient(colors: [Color("bgcolor"), .black]), center: .center, startRadius: 2, endRadius: 650))
            .foregroundColor(.white)
            .font(.system(size: 20))
            .fontWeight(.medium)
            .background(.opacity(0.05))
            .cornerRadius(20)
    }
}
