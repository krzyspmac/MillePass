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
                            NewsListRow.Item(id: "1", title: "Mille Beginnings", subTitle: "Pierwsze dni w pracy", milleIcon: "info.circle.fill", milleIconTint: .blue),
                            NewsListRow.Item(id: "2", title: "MilleCoins", subTitle: "Drobniaki na mille wydatki", milleIcon: "waveform.circle.fill", milleIconTint: .green),
//                            NewsListRow.Item(id: "3", title: "Mille godziny", subTitle: "Twoje godziny w pracy"),
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
        
        enum MilleStart {
            static var milleStartViewItem: MilleStartsView.Item {
                .init(rows:
                        [
                            .init(
                                id: "1",
                                title:  "Twój przełożony",
                                subTitle: "Szymon Szysz"
                            ),
                            .init(
                                id: "2",
                                title:  "Twój zespół",
                                subTitle: "Trafiłeś do najlepszego zespołu o nazwie Ahoj. Zespół zajmuje się wdrażaniem procesu selfie w aplikacji Banku Millennium"
                            ),
                            .init(
                                id: "3",
                                title:  "Helpdesk",
                                subTitle: "Jeżeli masz jakieś problemy dotyczące sprzętu zgłoś się na helpdesk. Telefon +48 22 598 4111"
                            )
                            
                        ]
                )
            }
        }
        
    }
}
