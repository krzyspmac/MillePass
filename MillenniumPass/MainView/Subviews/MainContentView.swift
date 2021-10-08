//
//  MainContentView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct MainContentView: View {
    
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack {
                
                Image(item.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                NewsList(items: NewsList.mockItems)
                
//                Text(item.title)
//                    .font(.largeTitle)
//                    .multilineTextAlignment(.center)
//
//                Divider()
//
//                HStack {
//                    Text(item.releasedAt)
//                    Text(item.language)
//                }
//                .font(.subheadline)
//
//                Divider()
//
//                item.overview.map {
//                    Text($0).font(.body)
//                }
            }
        }
//        .background(Color.backgroudColor)
        .padding(.horizontal, 10)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        return MainContentView(item: .init())
    }
}

extension MainContentView {
    struct Item: Equatable {
        var cardImage: String { "mille_card" }
        
    }
}

