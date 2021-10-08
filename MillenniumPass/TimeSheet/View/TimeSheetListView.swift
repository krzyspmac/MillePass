//
//  TimeSheetListView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct TimeSheetListView: View {
    
    let item: TimeSheetListView.Item
    
    var body: some View {
        VStack {
            Color.clear.frame(height: 20)
//            ForEach(item.rows.indices) { index in
            ForEach(Array(item.rows.enumerated()), id: \.offset) { index, itemRow in
//                let itemRow = item.rows[index]
                TimeSheetRowView(item: itemRow)
//                if index != item.rows.count - 1 {
//                    Color.separator.frame(height: 1).padding(.horizontal, 10)
//                }
            }
            Color.clear.frame(height: 20)
        }
    }
}

struct TimeSheetListView_Previews: PreviewProvider {
    static var previews: some View {
        return TimeSheetListView(item: MockFactory.Views.TimeSheet.timeSheetListItem)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color.backgroudColor)
    }
    
}

extension TimeSheetListView {
    
    struct Item: Equatable {
        let rows: [TimeSheetRowView.Item]
    }
    
}
