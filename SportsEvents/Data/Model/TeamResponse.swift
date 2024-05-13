//
//  TeamResponse.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation


struct TeamResponse: Codable {
    let success: Int
    let result: [Team]
}
