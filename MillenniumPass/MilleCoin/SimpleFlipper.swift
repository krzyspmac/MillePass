//
//  SimpleFlipper.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import SwiftUI


struct SimpleFlipper : View {
      @State var flipped = false

      var body: some View {

            let flipDegrees = flipped ? 180.0 : 0

            return VStack{
                  Spacer()

                  ZStack() {
                        FrontCard().flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
                        BackCard(coins: "25").flipRotate(-180 + flipDegrees).opacity(flipped ? 1.0 : 0.0)
                  }
                  .onAppear {
                      let baseAnimation = Animation.easeInOut(duration: 1.0)
                      let repeated = baseAnimation.repeatForever(autoreverses: false)
                      withAnimation(repeated) {
                          self.flipped.toggle()
                      }
                  }
//                  .animation(.easeInOut(duration: 0.8))
//                  .onTapGesture { self.flipped.toggle() }
                  Spacer()
            }
      }
}

struct SimpleFlipper_Previews: PreviewProvider {
    static var previews: some View {
        return SimpleFlipper()
    }
}

extension View {

      func flipRotate(_ degrees : Double) -> some View {
            return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
      }

      func placedOnCard(_ color: Color) -> some View {
            return padding(5).frame(width: 250, height: 150, alignment: .center).background(color)
      }
}

//struct FrontCard : View {
//      var body: some View {
//          ZStack {
//              Circle()
//                  .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
//                  .foregroundColor(.magenta)
//                  .frame(width: 100, height: 100)
//              Image("mille_icon")
//                  .renderingMode(.template)
//                  .resizable()
//                  .frame(width: 60, height: 60)
//                  .foregroundColor(.magenta)
//          }.frame(height: 100)
//      }
//}
//
//struct BackCard : View {
//      var body: some View {
//          ZStack {
//              Circle()
//                  .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
//                  .foregroundColor(.magenta)
//                  .frame(width: 100, height: 100)
//              Text("50")
//          }.frame(height: 100)
//      }
//}
