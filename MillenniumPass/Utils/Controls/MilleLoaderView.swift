//
//  MilleLoaderView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct MilleLoaderView: View {
 
    @State private var isLoading = false
 
    var body: some View {
        ZStack {
            
            Image("mille_icon")
                .resizable()
                .frame(width: 60, height: 60)
 
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 100, height: 100)
 
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.magenta, lineWidth: 5)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
            }
        }
    }
}

struct MilleLoaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MilleLoaderView()
        }
        .previewLayout(.fixed(width: 300, height: 170))
    }
    
}

