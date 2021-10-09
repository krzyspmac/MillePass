//
//  MilleCoinViewModel.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import Foundation
import FirebaseDatabase

final class MilleCoinViewModel: ViewModel {
    
    typealias E = MilleCoinViewModel.Event
    typealias S = MilleCoinViewModel.State
    
    @Published
    var state: MilleCoinViewModel.State
    
    // MARK: - Properties
    
    let databaseRef: DatabaseReference
    
    
    // MARK: - Init
    
    init(state: MilleCoinViewModel.State = .idle) {
        self.state = state
        databaseRef = Database.database(url: "https://millenniumpass-8e034-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    }

    
    // MARK: Handle new event
    
    func add(_ event: E) {
        switch event {
        case .onAppear:
            onViewDidAppear()
        }
    }
    
    private func onViewDidAppear() {
        state = .loading
        getInitialData()
    }
    
    private func getInitialData() {
        databaseRef.child("users/user1/coins").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
              }

            if let value = snapshot.value {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.state = .loaded(item: .init(coins: String(describing: value)))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.state = .loaded(item: .init(coins: "0"))
                }
            }
            
        }
    }
}

