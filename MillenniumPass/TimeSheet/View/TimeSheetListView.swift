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
            ForEach(Array(item.rows.enumerated()), id: \.offset) { index, itemRow in
                TimeSheetRowView(item: itemRow)
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
