//
//  SportsViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation

class SportsViewModel {
    
    var onSportClicked: ((Sport) -> Void)?
    var onSportsFetched: (() -> Void)?
    var dataSource: SportsDataSource
    var sports: [Sport] = []
    
    init(dataSource: SportsDataSource = LocalSportsDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchSports() {
        sports = dataSource.getSports()
        onSportsFetched?()
    }
    
    func handleSportClicked(for sport: Sport) {
        onSportClicked?(sport)
    }
}
