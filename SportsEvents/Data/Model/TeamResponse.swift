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
    let player_key: Int
    let player_image: String
    let player_name: String
    let player_number: String
    let player_country: String?
    let player_type: String
    let player_age: String
    let player_match_played: String
    let player_goals: String
    let player_yellow_cards: String
    let player_red_cards: String
    let player_injured: String
    let player_substitute_out: String
    let player_substitutes_on_bench: String
    let player_assists: String
    let player_birthdate: String
    let player_is_captain: String
    let player_shots_total: String
    let player_goals_conceded: String
    let player_fouls_committed: String
    let player_tackles: String
    let player_blocks: String
    let player_crosses_total: String
    let player_interceptions: String
    let player_clearances: String
    let player_dispossessed: String 
    let player_saves: String
    let player_inside_box_saves: String
    let player_duels_total: String
    let player_duels_won: String
    let player_dribble_attempts: String
    let player_dribble_succ: String
    let player_pen_comm: String
    let player_pen_won: String
    let player_pen_scored: String
    let player_pen_missed: String
    let player_passes: String
    let player_passes_accuracy: String
    let player_key_passes: String
    let player_woodworks: String
    let player_rating: String
}

