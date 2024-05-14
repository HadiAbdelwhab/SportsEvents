//
//  LeaguesViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Alamofire

class LeaguesViewModel {
    private var leagues: [League]?
    private var apiService: ApiService
    private let databaseManager: LocalDataSource
    
    init(apiService: ApiService = SportsApi.getApi(), databaseManager: LocalDataSource = SportsLocalDataSource()) {
        self.apiService = apiService
        self.databaseManager = databaseManager
    }
    
    func fetchLeagues(for sportTitle: String, completion: @escaping () -> Void) {
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)\(sportTitle.lowercased())/"
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: Leagues.self) { response in
            switch response.result {
            case .success(let leaguesResponse):
                self.leagues = leaguesResponse.result
                completion()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchFavoriteLeagues(completion: @escaping () -> Void) {
        print("Start To Get Favourite Leagues")
        databaseManager.fetchFavoriteLeagues { favoriteLeagues in
            print("get Favourite Successfully to viewModel And Here It is:\(favoriteLeagues)")
            self.leagues = favoriteLeagues
            completion()
        }
    }
    
    func getLeagues() -> [League]? {
        return leagues
    }
}
