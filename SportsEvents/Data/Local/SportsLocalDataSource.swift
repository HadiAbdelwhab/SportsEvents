//
//  SportsLocalDataSource.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//


import CoreData

class SportsLocalDataSource: LocalDataSource {
    static let shared = SportsLocalDataSource()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ScoreZone")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchFavoriteLeagues(completion: @escaping ([League]) -> Void) {
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        do {
            let favoriteLeagues = try viewContext.fetch(fetchRequest)
            
            let leagues = favoriteLeagues.map { league -> League in
                return League(leagueKey: Int(league.leagueKey),
                              leagueName: league.leagueName ?? "",
                              countryKey: Int(league.countryKey),
                              countryName: league.countryName ?? "",
                              leagueLogo: league.leagueLogo,
                              countryLogo: league.countryLogo)
            }
            completion(leagues)
        } catch {
            print("Error fetching favorite leagues: \(error)")
            completion([])
        }
    }
    
    func removeFavoriteLeague(leagueKey: Int) {
        let predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let favoriteLeagues = try viewContext.fetch(fetchRequest)
            for league in favoriteLeagues {
                viewContext.delete(league)
            }
            try viewContext.save()
        } catch {
            print("Error removing favorite league: \(error)")
        }
    }
    
    func addFavoriteLeagues(league: League) {
        let favoriteLeague = FavoriteLeague(context: viewContext)
        favoriteLeague.leagueKey = Int32(league.leagueKey)
        favoriteLeague.leagueName = league.leagueName
        favoriteLeague.countryKey = Int32(league.countryKey)
        favoriteLeague.countryName = league.countryName
        favoriteLeague.leagueLogo = league.leagueLogo
        favoriteLeague.countryLogo = league.countryLogo
        
        do {
            try viewContext.save()
        } catch {
            print("Error adding favorite league: \(error)")
        }
    }
}
