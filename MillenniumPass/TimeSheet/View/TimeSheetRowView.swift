//
//  TimeSheetView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct TimeSheetRowView: View {
    
    let item: Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: item.timeIcon)
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text(item.title)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(Color(UIColor.systemPink))
                }
                
                Text(item.subTitle)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(UIColor.systemGray))
            }
            Spacer()
            Text(item.dateText)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(UIColor.systemPink))
        }
        .padding(.horizontal, 10)
    }
}

extension TimeSheetRowView {
    struct Item: Identifiable, Equatable {
        let id: String
        let title: String
        let subTitle: String
        let dateText: String
        var timeIcon: String { "stopwatch" }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

struct TimeSheetRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TimeSheetRowView(item: .init(
                id: "1",
                title:  "Czas pracy",
                subTitle: "08:30",
                dateText: "10.02"
            )
            )
            TimeSheetRowView(item: .init(
                id: "2",
                title:  "Czas pracy",
                subTitle: "08:30",
                dateText: "11.02"
            )
            )
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
    
}
