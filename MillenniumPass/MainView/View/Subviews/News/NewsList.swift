//
//  NewsList.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct NewsList: View {
    
    let items: [NewsListRow.Item]
    
    var body: some View {
        VStack {
            Color.clear.frame(height: 20)
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                NewsListRow(item: item)
                if index != items.count - 1 {
                    Color.separator.frame(height: 1).padding(.horizontal, 10)
                }
            }
            Color.clear.frame(height: 20)
        }
        .background(Color.white)
        .cornerRadius(30)
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        return NewsList(items: NewsList.mockItems)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color.backgroudColor)
    }
    
}

extension NewsList {
    
    static var mockItems: [NewsListRow.Item] {
        [
            NewsListRow.Item(id: "1", title: "Mille początki", subTitle: "Pierwsze dni w pracy"),
            NewsListRow.Item(id: "2", title: "MilleCoin", subTitle: "Drobniaki na mille wydatki"),
            NewsListRow.Item(id: "3", title: "Mille godziny", subTitle: "Twoje godziny w pracy"),
        ]
    }
}
