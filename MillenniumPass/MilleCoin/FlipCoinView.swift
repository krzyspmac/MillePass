//
//  FlipCoinView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import SwiftUI

struct ExampleCard: View {
    @State var flipped = false // state variable used to update the card
    
    var body: some View {
        
        
        coinView
            .foregroundColor(self.flipped ? .red : .blue) // change the card color when flipped
            .padding()
            .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
//            .animation(.default) // implicitly applying animation
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 1.0)
                let repeated = baseAnimation.repeatForever(autoreverses: false)
                withAnimation(repeated) {
                    self.flipped.toggle()
                }
            }
//            .onTapGesture {
//                // explicitly apply animation on toggle (choose either or)
//                //withAnimation {
//                    self.flipped.toggle()
//                //}
//        }
        
    }
    
    private var coinView: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
                .foregroundColor(.magenta)
                .frame(width: 100, height: 100)
            Image("mille_icon")
                .renderingMode(.template)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.magenta)
        }.frame(height: 100)
    }
}

struct ExampleCard_Previews: PreviewProvider {
    static var previews: some View {
        ExampleCard()
    }
}
