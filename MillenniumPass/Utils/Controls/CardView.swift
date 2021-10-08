//
//  CardView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct CardView: View {
    
    let item: Item
    
    var body: some View {
        ZStack {
            Color.magenta
                .asAnyView
                .aspectRatio(1.58, contentMode: .fit)
            
            Image("mille_icon")
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(0.1)
            
            HStack {
                Text(item.name).padding()
                Spacer()
                if let image = item.uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 70, height: 80)
                        .padding()
                }
                
            }
        }
        .cornerRadius(10)
    }
}

extension CardView {
    struct Item: Equatable {
        let name: String
        let uiImage: UIImage?
        var milleIcon: String { "card_placeholder" }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.name == rhs.name
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CardView(item: .init(
                name: "Szymon Szysz", uiImage: .none
            )
            )
        }
        .previewLayout(.fixed(width: 300, height: 190))
    }
    
}
