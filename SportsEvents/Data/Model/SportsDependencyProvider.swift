//
//  SportsDependencyProvider.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation


class SportsDependencyProvider {
    private static let apiService = SportsApi()
    private static let databaseManager = SportsLocalDataSource()
    
    static func provideLeaguesViewModel() -> LeaguesViewModel {
        return LeaguesViewModel(apiService: self.apiService, databaseManager: databaseManager)
    }

    static func provideLeagueDetailsViewModel() -> LeagueDetailsViewModel {
        return LeagueDetailsViewModel(apiService: self.apiService)
    }
    
    static func provideTeamViewModel() -> TeamViewModel {
        return TeamViewModel(apiService: self.apiService)
    }
}
