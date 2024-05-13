//
//  Team.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation

struct Team: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
}
