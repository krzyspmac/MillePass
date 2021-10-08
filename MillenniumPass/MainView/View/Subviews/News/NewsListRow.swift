//
//  NewsListRow.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct NewsListRow: View {
    
    let item: Item
    
    var body: some View {
        HStack {
            Image(item.milleIcon)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(UIColor.systemPink))
                Text(item.subTitle)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .aspectRatio(contentMode: .fit)
        }
        .padding(.horizontal, 10)
    }
}

extension NewsListRow {
    struct Item: Identifiable, Equatable {
        let id: String
        let title: String
        let subTitle: String
        var milleIcon: String { "mille_icon" }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

struct NewsListRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NewsListRow(item: .init(
                                    id: "1",
                                    title:  "Mille początki",
                                    subTitle: "Pierwsze dni w pracy"
                                )
            )
            NewsListRow(item: .init(
                                    id: "2",
                                    title:  "MilleCoin",
                                    subTitle: "Drobniaki na mille wydatki"
                                )
            )
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
    
}
