//
//  MockFactory.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation


enum MockFactory {
    
    enum ViewModel {
        static var timeSheetViewModel: TimeSheetViewModel {
            TimeSheetViewModel(state: .idle)
        }
        
        static var mainViewModel: MainViewModel {
            MainViewModel(state: .idle)
        }
    }
    
    
    enum Views {
        enum Main {
            
            static var mainContentViewItem: MainContentView.Item {
                .init(timeViewItem: Self.timeViewItem, newsListItem: Self.newsListItem)
            }
            
            static var newsListItem: NewsList.Item {
                .init(rows:
                        [
                            NewsListRow.Item(id: "1", title: "Mille początki", subTitle: "Pierwsze dni w pracy"),
                            NewsListRow.Item(id: "2", title: "MilleCoin", subTitle: "Drobniaki na mille wydatki"),
                            NewsListRow.Item(id: "3", title: "Mille godziny", subTitle: "Twoje godziny w pracy"),
                        ]
                )
            }
            static var timeViewItem: TimeView.Item {
                .init(title: "Twój czas pracy", time: "08:20")
            }
        }
        
        enum TimeSheet {
            
            static var timeSheetViewItem: TimeSheetView.Item {
                .init(timeSheetItem: Self.timeSheetListItem)
            }
            
            static var timeSheetListItem: TimeSheetListView.Item {
                .init(rows:
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
                )
            }
        }
        
    }
}
