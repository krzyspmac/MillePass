//
//  FlippingView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import SwiftUI

struct FlippingView: View {
    
    let coins: String

      @State private var flipped = false
      @State private var animate3d = false

      var body: some View {

            return VStack {
                  Spacer()

                  ZStack() {
                        FrontCard().opacity(flipped ? 0.0 : 1.0)
                        BackCard(coins: coins).opacity(flipped ? 1.0 : 0.0)
                  }
                  .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
//                  .onTapGesture {
//                        withAnimation(Animation.linear(duration: 0.8)) {
//                              self.animate3d.toggle()
//                        }
//                  }
                  .onAppear {
                      let baseAnimation = Animation.easeInOut(duration: 1.5)
                      let repeated = baseAnimation.repeatForever(autoreverses: true)
                      withAnimation(repeated) {
                          self.animate3d.toggle()
                      }
                  }
                  Spacer()
            }
      }
}

struct FlippingView_Previews: PreviewProvider {
    static var previews: some View {
        return FlippingView(coins: "20")
    }
}

struct FlipEffect: GeometryEffect {

      var animatableData: Double {
            get { angle }
            set { angle = newValue }
      }

      @Binding var flipped: Bool
      var angle: Double
      let axis: (x: CGFloat, y: CGFloat)

      func effectValue(size: CGSize) -> ProjectionTransform {

            DispatchQueue.main.async {
                  self.flipped = self.angle >= 90 && self.angle < 270
            }

            let tweakedAngle = flipped ? -180 + angle : angle
            let a = CGFloat(Angle(degrees: tweakedAngle).radians)

            var transform3d = CATransform3DIdentity;
            transform3d.m34 = -1/max(size.width, size.height)

            transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
            transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))

            return ProjectionTransform(transform3d).concatenating(affineTransform)
      }
}

struct FrontCard : View {
      var body: some View {
          ZStack {
              Circle()
                  .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
                  .foregroundColor(.magenta)
                  .frame(width: 200, height: 200)
              Image("mille_icon")
                  .renderingMode(.template)
                  .resizable()
                  .frame(width: 60*2, height: 60*2)
                  .foregroundColor(.magenta)
          }.frame(height: 200)
      }
}

struct BackCard : View {
    let coins: String
      var body: some View {
          ZStack {
              Circle()
                  .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
                  .foregroundColor(.magenta)
                  .frame(width: 200, height: 200)
              Text(coins)
                  .font(.system(size: 70))
                  .bold()
          }.frame(height: 200)
      }
}
