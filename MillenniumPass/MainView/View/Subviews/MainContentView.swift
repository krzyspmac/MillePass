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
                
                let name = UserManager.shared.loggedInUser?.name ?? "Szymon"
                let surname = UserManager.shared.loggedInUser?.surname ?? "Szysz"
                let image = UserManager.shared.loggedInUser?.uiImage
                
                CardView(item: .init(
                    name: name + " " + surname,
                    uiImage: image))
                NewsList(item: item.newsListItem)
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        return MainContentView(item: MockFactory.Views.Main.mainContentViewItem)
    }
}

extension MainContentView {
    struct Item: Equatable {
        var cardImage: String { "mille_card" }
        let timeViewItem: TimeView.Item
        let newsListItem: NewsList.Item
    }
}

