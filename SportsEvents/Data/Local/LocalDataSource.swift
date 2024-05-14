//
//  LocalDataSource.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation
protocol LocalDataSource {
    func fetchFavoriteLeagues(completion: @escaping ([League]) -> Void)
    func removeFavoriteLeague(leagueKey: Int)
}
