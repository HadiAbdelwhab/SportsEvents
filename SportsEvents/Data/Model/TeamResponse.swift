//
//  TeamResponse.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

struct TeamResponse: Codable {
    let success: Int
    let result: [Team]
}


struct Team: Codable {
    let team_key: Int
    let team_name: String
    let team_logo: String
    let players: [Player]
}


struct Player: Codable {
    let player_key: Int?
    let player_image: String?
    let player_name: String?
    let player_number: String?
    let player_type: String?
    let player_age: String?
    
}
