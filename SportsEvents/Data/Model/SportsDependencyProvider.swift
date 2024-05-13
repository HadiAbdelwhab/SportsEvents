//
//  SportsDependencyProvider.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation


class SportsDependencyProvider {
    private static let apiService = SportsApi()
 

    static func provideLeagueDetailsViewModel() -> LeagueDetailsViewModel {
        return LeagueDetailsViewModel(apiService: self.apiService)
    }
}
