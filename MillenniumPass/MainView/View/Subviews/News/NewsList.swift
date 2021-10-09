//
//  NewsList.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct NewsList: View {
    
    let item: NewsList.Item
    
    var body: some View {
        VStack {
            Color.clear.frame(height: 5)
            
            let item1 = NewsListRow.Item(id: "1", title: "Mille początki", subTitle: "Pierwsze dni w pracy")
            NavigationLink(
                destination: MilleStartsView(viewModel: .init(state: .idle)),
                label: { NewsListRow(item: item1) }
            )
            
            let item2 = NewsListRow.Item(id: "2", title: "MilleCoin", subTitle: "Drobniaki na mille wydatki")
            
            Color.separator.frame(height: 1).padding(.horizontal, 10)
            
            NavigationLink(
                destination: MilleCoinView(viewModel: .init(state: .idle)),
                label: { NewsListRow(item: item2) }
            )
            
            
//            ForEach(Array(item.rows.enumerated()), id: \.offset) { index, rowItem in
//                NavigationLink(
//                    destination: MilleStartsView(viewModel: .init(state: .idle)),
//                    label: { NewsListRow(item: rowItem) }
//                )
//                if index != item.rows.count - 1 {
//                    Color.separator.frame(height: 1).padding(.horizontal, 10)
//                }
//            }
            Color.clear.frame(height: 5)
        }
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        return NewsList(item: MockFactory.Views.Main.newsListItem)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color.backgroudColor)
    }
}

extension NewsList {
    
    struct Item: Equatable {
        var rows: [NewsListRow.Item]
    }
    
    static var mockItems: [NewsListRow.Item] {
        [
            NewsListRow.Item(id: "1", title: "Mille początki", subTitle: "Pierwsze dni w pracy"),
            NewsListRow.Item(id: "2", title: "MilleCoin", subTitle: "Drobniaki na mille wydatki"),
//            NewsListRow.Item(id: "3", title: "Mille godziny", subTitle: "Twoje godziny w pracy"),
        ]
    }
}
