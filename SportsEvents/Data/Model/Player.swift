//
//  Player.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation

struct Player: Codable {
    let playerKey: Int
    let playerName: String
    let playerImage: String
    let playerNumber: String
    let playerCountry: String?
    let playerType: String
    let playerAge: String
    let playerMatchPlayed: String
    let playerGoals: String
    let playerYellowCards: String
    let playerRedCards: String
    let playerInjured: String
    let playerSubstituteOut: String
    let playerSubstitutesOnBench: String
    let playerAssists: String
    let playerBirthdate: String
    let playerIsCaptain: String
    let playerShotsTotal: String
    let playerGoalsConceded: String
    let playerFoulsCommitted: String
    let playerTackles: String
    let playerBlocks: String
    let playerCrossesTotal: String
    let playerInterceptions: String
    let playerClearances: String
    let playerDispossessed: String
    let playerSaves: String
    let playerInsideBoxSaves: String
    let playerDuelsTotal: String
    let playerDuelsWon: String
    let playerDribbleAttempts: String
    let playerDribbleSuccess: String
    let playerPenComm: String
    let playerPenWon: String
    let playerPenScored: String
    let playerPenMissed: String
    let playerPasses: String
    let playerPassesAccuracy: String
    let playerKeyPasses: String
    let playerWoodworks: String
    let playerRating: String
}
