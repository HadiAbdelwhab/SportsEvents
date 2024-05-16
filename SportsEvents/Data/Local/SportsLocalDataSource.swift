//
//  SportsLocalDataSource.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//


import CoreData
import UIKit

class SportsLocalDataSource: LocalDataSource {
    static let shared = SportsLocalDataSource()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var viewContext : NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func fetchFavoriteLeagues(completion: @escaping ([League]) -> Void) {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FLeague")
        var leagues: [League] = []
        do {
            let favouriteLeagues = try viewContext.fetch(fetchRequest)
            print(favouriteLeagues.count)
            for item in favouriteLeagues {
                print(item)
                leagues.append(convertFromNsManagedObject(object: item))
            }
            print(leagues.count)
            completion(leagues)
        } catch {
            print("Error fetching favorite leagues: \(error)")
            completion([])
        }
    }
    
    func convertFromNsManagedObject(object : NSManagedObject) -> League{
        
        let leagueKey = object.value(forKey: "leagueKey") as! Int
        let leagueName = object.value(forKey: "leagueName") as! String
        let countryKey = object.value(forKey: "countryKey") as! Int
        let countryName = object.value(forKey: "countryName") as! String
        let leagueLogo = object.value(forKey: "leagueLogo") as? String
        let countryLogo = object.value(forKey: "countryLogo") as? String
        let sportName = object.value(forKey: "sportName") as? String
        let result = League(leagueKey: leagueKey, leagueName: leagueName, countryKey: countryKey, countryName: countryName, leagueLogo: leagueLogo, countryLogo: countryLogo, sportName: sportName)
        
        return result
    }
    
    func removeFavoriteLeague(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FLeague")
        let predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
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
        guard let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "FLeague", in: viewContext) else {
            print("Unable to find entity description for League")
            return
        }
        
        let favoriteLeague: NSManagedObject = NSManagedObject(entity: entity, insertInto: viewContext)
        favoriteLeague.setValue(league.countryKey, forKey: "countryKey")
        favoriteLeague.setValue(league.countryLogo, forKey: "countryLogo")
        favoriteLeague.setValue(league.countryName, forKey: "countryName")
        favoriteLeague.setValue(league.leagueKey, forKey: "leagueKey")
        favoriteLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favoriteLeague.setValue(league.leagueName, forKey: "leagueName")
        favoriteLeague.setValue(league.sportName, forKey: "sportName")
        
        do {
            try viewContext.save()
        } catch {
            print("Error adding favorite league: \(error)")
        }
    }
}
