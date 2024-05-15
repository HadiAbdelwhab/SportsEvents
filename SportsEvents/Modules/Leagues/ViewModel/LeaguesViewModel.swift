//
//  LeaguesViewModel.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

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
        
        apiService.makeCallToApi(url: apiUrl, params: parameters) { (leagues: Leagues?, error: Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.leagues = leagues?.result
                completion()
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
    
    func removeLeague(_ leagueKey: Int) {
        leagues = leagues?.filter { $0.leagueKey != leagueKey }
        
        databaseManager.removeFavoriteLeague(leagueKey: leagueKey)
    }
    
    func getLeagues() -> [League]? {
        return leagues
    }
}
