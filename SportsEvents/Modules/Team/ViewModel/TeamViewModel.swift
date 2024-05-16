//
//  TeamViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

class TeamViewModel {
    
    private var teams: [Team]?
    
    private var apiService: ApiService!
    
    init(apiService: ApiService = SportsApi.api) {
        self.apiService = apiService
    }
    
    func fetchTeamDetails(sportTitle: String, teamId: String, completion: @escaping () -> Void) {
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "teamId": teamId,
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        apiService.makeCallToApi(url: apiUrl, params: parameters) { (teams: TeamResponse?, error: Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.teams = teams?.result
                completion()
            }
        }
    }
    
    func getTeams() -> [Team]? {
        return teams
    }
}
