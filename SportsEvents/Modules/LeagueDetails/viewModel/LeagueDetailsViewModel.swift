//
//  LeagueDetailsViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation
import Alamofire

class LeagueDetailsViewModel {
    
    private var upComingEventsResponse: EventsResponse?
    private var latestResultsResponse: EventsResponse?
    private var teamsResponse: TeamResponse?
    
    private var apiService: ApiService
    private let databaseManager: LocalDataSource
    
    init(apiService: ApiService = SportsApi.getApi(), databaseManager: LocalDataSource = SportsLocalDataSource()){
        self.apiService = apiService
        self.databaseManager = databaseManager
    }
    
    func fetchUpcomingEvents(for sportTitle: String, leagueId: Int, completion: @escaping () -> Void) {
        let currentDate = Date()
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: 0, to: currentDate)!
        let toDate = calendar.date(byAdding: .day, value: 5, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": dateFormatter.string(from: fromDate),
            "to": dateFormatter.string(from: toDate),
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
        print(apiUrl)
        apiService.makeCallToApi(url: apiUrl, params: parameters){ (response: EventsResponse?, error:
                                                                        Error?) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.upComingEventsResponse = response
                completion()
            }
            
        }
            
        
        
    }
    
    func fetchLatestResults(for sportTitle: String, leagueId: Int, completion: @escaping () -> Void) {
            let currentDate = Date()
            let oneYearAgoDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let parameters: [String: Any] = [
                "met": "Fixtures",
                "leagueId": leagueId,
                "from": dateFormatter.string(from: oneYearAgoDate),
                "to": dateFormatter.string(from: currentDate),
                "APIkey": ApiURLs.API_KEY.rawValue
            ]
            
            let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
            print(apiUrl)
            apiService.makeCallToApi(url: apiUrl, params: parameters) { (response: EventsResponse?, error: Error?) in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    self.latestResultsResponse = response
                    completion()
                }
            }
        }

    
    func fetchAllTeams(for leagueId: Int, completion: @escaping () -> Void) {
            let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
            let parameters: [String: Any] = [
                "met": "Teams",
                "leagueId": leagueId,
                "APIkey": ApiURLs.API_KEY.rawValue
            ]
            apiService.makeCallToApi(url: apiUrl, params: parameters) { (response: TeamResponse?, error: Error?) in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    self.teamsResponse = response
                    completion()
                }
            }
        }
        
    
    func addLeagueToFavourite(){
        
    }
    
    func getUpcomingEvents() -> EventsResponse? {
        return upComingEventsResponse
    }
    
    func getLatestResults() -> EventsResponse? {
        return latestResultsResponse
    }
    
    func getAllTeams() -> TeamResponse? {
        return teamsResponse
    }
}
