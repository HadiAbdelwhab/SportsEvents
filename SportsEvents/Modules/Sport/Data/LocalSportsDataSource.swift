//
//  LocalSportsDataSource.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import Foundation

class LocalSportsDataSource: SportsDataSource {
    func getSports() -> [Sport] {
        return [
            Sport(title: "Football", format: "11-a-side", thumb: "football.jpg", description: "Football is a popular team sport played with a spherical ball between two teams of eleven players. It is widely considered the most popular sport in the world."),
            Sport(title: "Basketball", format: "5-a-side", thumb: "basketball.jpg", description: "Basketball is a team sport in which two teams, most commonly of five players each, opposing one another on a rectangular court, compete with the primary objective of shooting a basketball through the defender's hoop."),
            Sport(title: "Tennis", format: "Singles/Doubles", thumb: "tennis.jpg", description: "Tennis is a racket sport that can be played individually against a single opponent (singles) or between two teams of two players each (doubles). Each player uses a tennis racket that is strung with cord to strike a hollow rubber ball covered with felt over or around a net and into the opponent's court."),
            Sport(title: "Cricket", format: "Test/T20", thumb: "cricket.jpg", description: "Cricket is a bat-and-ball game played between two teams of eleven players on a field at the center of which is a 22-yard pitch with a wicket at each end, each comprising two bails balanced on three stumps.")
        ]
    }
}
