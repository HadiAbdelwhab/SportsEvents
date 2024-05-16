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
        let container = NSPersistentContainer(name: "ScoreEvents")
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
        let fetchRequest: NSFetchRequest<FavoriteLeague> = NSFetchRequest(entityName: "FavoriteLeague")
        
        do {
            let favoriteLeagues = try viewContext.fetch(fetchRequest)
            
            let leagues = favoriteLeagues.compactMap { league -> League? in
                guard let leagueKeyString = league.value(forKey: "leagueKey") as? String,
                      let leagueName = league.value(forKey: "leagueName") as? String,
                      let countryKeyString = league.value(forKey: "countryKey") as? String,
                      let countryName = league.value(forKey: "countryName") as? String,
                      let leagueKey = Int(leagueKeyString),
                      let countryKey = Int(countryKeyString) else {
                    return nil
                }
                
                return League(leagueKey: leagueKey,
                              leagueName: leagueName,
                              countryKey: countryKey,
                              countryName: countryName,
                              leagueLogo: league.value(forKey: "leagueLogo") as? String,
                              countryLogo: league.value(forKey: "countryLogo") as? String)
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
        guard let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: viewContext) else {
            print("Unable to find entity description for Movie")
            return
        }
        
        var favoriteLeague: NSManagedObject = NSManagedObject(entity: entity, insertInto: viewContext)
        favoriteLeague.setValue(league.countryKey, forKey: "countryKey")
        favoriteLeague.setValue(league.countryLogo, forKey: "countryLogo")
        favoriteLeague.setValue(league.countryName, forKey: "countryName")
        favoriteLeague.setValue(league.leagueKey, forKey: "leagueKey")
        favoriteLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favoriteLeague.setValue(league.leagueName, forKey: "leagueName")
        
        do {
            try viewContext.save()
        } catch {
            print("Error adding favorite league: \(error)")
        }
    }
}
