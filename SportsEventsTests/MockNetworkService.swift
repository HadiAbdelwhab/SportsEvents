//
//  MockNetworkService.swift
//  SportsEventsTests
//
//  Created by JETSMobileLabMini14 on 15/05/2024.
//

import Foundation
@testable import SportsEvents

class MockNetworkService {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let leaguesData: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 1,
                "league_name": "Premier League",
                "country_key": 1,
                "country_name": "England",
                "league_logo": "premier_league_logo.png",
                "country_logo": "england_logo.png"
            ],
            [
                "league_key": 2,
                "league_name": "La Liga",
                "country_key": 2,
                "country_name": "Spain",
                "league_logo": "la_liga_logo.png",
                "country_logo": "spain_logo.png"
            ]
        ]
    ]
    
    let teamsData: [String: Any] = [
            "success": 1,
            "result": [
                [
                    "team_key": 1,
                    "team_name": "Team 1",
                    "team_logo": "team1_logo.png",
                    "players": [
                        [
                            "player_key": 1,
                            "player_image": "player1.jpg",
                            "player_name": "Player 1",
                            "player_number": "10",
                            "player_type": "Forward",
                            "player_age": "25"
                        ],
                        [
                            "player_key": 2,
                            "player_image": "player2.jpg",
                            "player_name": "Player 2",
                            "player_number": "5",
                            "player_type": "Defender",
                            "player_age": "28"
                        ]
                    ]
                ]
            ]
        ]
}

extension MockNetworkService {
    
    func fetchLeagues(completion: @escaping (Leagues?, Error?) -> Void) {
        var result: Leagues?
        do {
            let data = try JSONSerialization.data(withJSONObject: leaguesData)
            result = try JSONDecoder().decode(Leagues.self, from: data)
        } catch let error {
            print(error)
        }
        
        enum ResponseWithError: Error {
            case errorInResponce
        }
        
        if shouldReturnError {
            completion(nil, ResponseWithError.errorInResponce)
        } else {
            completion(result, nil)
        }
    }
    
    func fetchTeams(completion: @escaping (TeamResponse?, Error?) -> Void) {
        var result: TeamResponse?
        do {
            let data = try JSONSerialization.data(withJSONObject: teamsData)
            result = try JSONDecoder().decode(TeamResponse.self, from: data)
        } catch let error {
            print(error)
        }
        
        enum ResponseWithError: Error {
            case errorInResponce
        }
        
        if shouldReturnError {
            completion(nil, ResponseWithError.errorInResponce)
        } else {
            completion(result, nil)
        }
    }
    
    func fetchUpcomingEvents(completion: @escaping (EventsResponse?, Error?) -> Void) {
        var result: EventsResponse?
        do {
            let data = try JSONSerialization.data(withJSONObject: leaguesData)
            result = try JSONDecoder().decode(EventsResponse.self, from: data)
        } catch let error {
            print(error)
        }
        
        enum ResponseWithError: Error {
            case errorInResponce
        }
        
        if shouldReturnError {
            completion(nil, ResponseWithError.errorInResponce)
        } else {
            completion(result, nil)
        }
    }
    
    func fetchLatestResults(completion: @escaping (EventsResponse?, Error?) -> Void) {
        var result: EventsResponse?
        do {
            let data = try JSONSerialization.data(withJSONObject: leaguesData)
            result = try JSONDecoder().decode(EventsResponse.self, from: data)
        } catch let error {
            print(error)
        }
        
        enum ResponseWithError: Error {
            case errorInResponce
        }
        
        if shouldReturnError {
            completion(nil, ResponseWithError.errorInResponce)
        } else {
            completion(result, nil)
        }
    }
}
