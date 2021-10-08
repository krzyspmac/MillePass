//
//  TimeSheetListView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct TimeSheetListView: View {
    
    let items: [TimeSheetRowView.Item]
    
    var body: some View {
        VStack {
            Color.clear.frame(height: 20)
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                TimeSheetRowView(item: item)
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

struct TimeSheetListView_Previews: PreviewProvider {
    static var previews: some View {
        return TimeSheetListView(items: TimeSheetListView.mockItems)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color.backgroudColor)
    }
    
}

extension TimeSheetListView {
    
    static var mockItems: [TimeSheetRowView.Item] {
        [
            .init(
                id: "1",
                title:  "Czas pracy",
                subTitle: "08:30",
                dateText: "10.02"
            ),
            .init(
                id: "2",
                title:  "Czas pracy",
                subTitle: "08:30",
                dateText: "11.02"
            )
        ]
    }
}
