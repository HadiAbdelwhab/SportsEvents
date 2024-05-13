//
//  TeamViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation

class TeamViewModel {
    
    private var teams: [Team]?
    
    private var apiService: ApiService!
    
    init(apiService: ApiService = SportsApi.getApi()) {
        self.apiService = apiService
    }
    
    func fetchTeamDetails(sportTitle: String, teamId: String, completion: @escaping () -> Void) {
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/?&met=Teams&teamId=\(teamId)&APIkey=\(ApiURLs.API_KEY.rawValue)"
        print(apiUrl)
        apiService.makeCallToApi(url: apiUrl) { (response: TeamResponse?, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let response = response {
                self.teams = response.result
                print(response.result)
                completion()
            }
        }
    }
    
    func getTeams() -> [Team]? {
        return teams
    }
}
