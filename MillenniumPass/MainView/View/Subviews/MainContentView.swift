//
//  MainContentView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct MainContentView: View {
    
    let item: Item
    
    @StateObject
    var userManager: UserManager = .shared
    
    var body: some View {
        ZStack {
            Color.backgroudColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    let name = UserManager.shared.user?.name ?? "Szymon"
                    let surname = UserManager.shared.user?.surname ?? "Szysz"
                    let image = UserManager.shared.user?.uiImage
                    
                    CardView(item: .init(
                        name: name + " " + surname,
                        uiImage: image)
                    )
                    .onTapGesture {
                        NFCReader.shared.startReading()
                    }
                    
                    LoggedInView(userManager: userManager)
                    
                    NewsList(item: item.newsListItem)
                }
            }.padding(.horizontal, 10)
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
