//
//  TimeView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct TimeView: View {
    
    let item: Item
    
    var body: some View {
        VStack {
            HStack() {
                Text(item.title)
                    .font(.system(.headline, design: .rounded))
                Spacer()
            }
            Text(item.time)
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .foregroundColor(.black)
            
        }
        .padding(.horizontal, 10)
    }
}

extension TimeView {
    struct Item: Equatable {
        let title: String
        let time: String
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.title == rhs.title
        }
    }
    
    static var mock: TimeView.Item {
        .init(title: "Twój czas pracy", time: "08:20")
    }
}

struct TimeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TimeView(item: TimeView.mock
            )
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
    
}
