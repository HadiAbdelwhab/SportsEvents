//
//  TeamViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Alamofire

class TeamViewModel {
    
    private var teams: [Team]?
    
    private var apiService: ApiService!
    
    init(apiService: ApiService = SportsApi.getApi()) {
        self.apiService = apiService
    }
    
    func fetchTeamDetails(sportTitle: String, teamId: String, completion: @escaping () -> Void) {
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "teamId": teamId,
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: TeamResponse.self) { response in
            switch response.result {
            case .success(let teamResponse):
                self.teams = teamResponse.result
                print(teamResponse.result)
                completion()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTeams() -> [Team]? {
        return teams
    }
}
