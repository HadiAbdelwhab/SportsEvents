//
//  SportsDataSource.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation
protocol SportsDataSource {
    func getSports() -> [Sport]
}
