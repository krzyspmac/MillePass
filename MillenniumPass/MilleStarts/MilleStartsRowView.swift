//
//  MilleStartsRowView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct MilleStartsRowView: View {
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: item.icon)
                    .resizable()
                    .frame(width: 15, height: 15)
                VStack(spacing: 8) {
                    HStack {
                        Text(item.title)
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(Color(UIColor.systemPink))
                        Spacer()
                    }
                    
                    HStack {
                        Text(item.subTitle)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color(UIColor.systemGray))
                        Spacer()
                    }
                    
                }
                Spacer()
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

extension MilleStartsRowView {
    struct Item: Identifiable, Equatable {
        let id: String
        let title: String
        let subTitle: String
        var icon: String { "star.fill" }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

struct MilleStartsRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MilleStartsRowView(item: .init(
                id: "1",
                title:  "Twój przełożony",
                subTitle: "Szymon Szysz"
            )
            )
            MilleStartsRowView(item: .init(
                id: "2",
                title:  "Czas pracy",
                subTitle: "08:30"
            )
            )
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
    
}

