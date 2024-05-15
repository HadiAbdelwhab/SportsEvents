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
        
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: EventsResponse.self) { response in
            switch response.result {
            case .success(let eventsResponse):
                self.upComingEventsResponse = eventsResponse
                completion()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchLatestResults(for sportTitle: String, leagueId: Int, completion: @escaping () -> Void) {
        let currentDate = Date()
        let oneWeekAgoDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": dateFormatter.string(from: oneWeekAgoDate),
            "to": dateFormatter.string(from: currentDate),
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
        
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: EventsResponse.self) { response in
            switch response.result {
            case .success(let eventsResponse):
                self.latestResultsResponse = eventsResponse
                completion()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    func fetchAllTeams(for leagueId: Int, completion: @escaping (TeamResponse?, Error?) -> Void) {
                let apiUrl = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=\(leagueId)&APIkey=d2538bc4458303020afacfc7511cb9f5808e36e454a61508dcb8a7ade6984775"
                
                print(apiUrl)
                apiService.makeCallToApi(url: apiUrl) { (response: TeamResponse?, error) in
                    if let error = error {
                        completion(nil, error)
                        print(error)
                    } else if let response = response {
                        self.teamsResponse = response
                        completion(response, nil)
                    }
                }
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
