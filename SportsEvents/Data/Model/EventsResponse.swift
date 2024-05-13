//
//  UpComingEvents.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation

class EventsResponse : Codable{
    
    var success:Int
    var reslut:[Events]
    
}

class Events : Codable{
 
    
    var event_key:Int
    var event_date:String
    
    var event_home_team:String
    var home_team_key:Int
    var home_team_logo:String
    
    var event_away_team:String
    var away_team_key:Int
    var away_team_logo:String
    
    var league_name:String
    var league_key:Int
    var league_logo:String
    var league_round:String
    
    var event_final_result:String
    
    
}
