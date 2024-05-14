//
//  LeagueDetailsViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation

class LeagueDetailsViewModel {
    
    
    private var upComingEventsResponse: EventsResponse?
    private var leatesReulst:EventsResponse?
    private var teamsResponse:TeamResponse?
    
    private var apiService: ApiService = SportsApi.getApi()
    
    init( apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchUpcomingEvents(for sportTitle: String, leagueId: Int, completion: @escaping () -> Void) {
        let currentDate = Date()
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: 0, to: currentDate)!
        let toDate = calendar.date(byAdding: .day, value: 5, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/?met=Fixtures&leagueId=\(leagueId)&from=\(dateFormatter.string(from: fromDate))&to=\(dateFormatter.string(from: toDate))&APIkey=\(ApiURLs.API_KEY.rawValue)"
        
        print(apiUrl)
        
        apiService.makeCallToApi(url: apiUrl) { (response: EventsResponse?, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let response = response {
                self.upComingEventsResponse = response
                completion()
            }
        }
    }
    
    
    
    func fetchLatestResults(for leagueId: Int, completion: @escaping () -> Void) {
            let currentDate = Date()
            let oneYearAgoDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football?met=Fixtures&leagueId=\(leagueId)&from=\(dateFormatter.string(from: oneYearAgoDate))&to=\(dateFormatter.string(from: currentDate))&APIkey=\(ApiURLs.API_KEY.rawValue)"
            
            print(apiUrl)
            
            apiService.makeCallToApi(url: apiUrl) { (response: EventsResponse?, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let response = response {
                    self.leatesReulst = response
                    completion()
                }
            }
        }
    
    func fetchAllTeams(for leagueId: Int, completion: @escaping (TeamResponse?, Error?) -> Void) {
            let apiUrl = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=\(leagueId)&APIkey=d2538bc4458303020afacfc7511cb9f5808e36e454a61508dcb8a7ade6984775"
            
            apiService.makeCallToApi(url: apiUrl) { (response: TeamResponse?, error) in
                if let error = error {
                    completion(nil, error)
                } else if let response = response {
                    self.teamsResponse = response
                    completion(response, nil)
                }
            }
        }
    
    
    func getUpcomingEvents() -> EventsResponse? {
        return upComingEventsResponse
    }
    
    
    func getLeatesResult() -> EventsResponse? {
        return upComingEventsResponse
    }
    
    func getAllTeams() -> TeamResponse? {
        return teamsResponse
    }
}
