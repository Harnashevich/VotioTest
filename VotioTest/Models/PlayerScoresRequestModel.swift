//
//  PlayerScoresRequestModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 8.04.24.
//

import Foundation

struct PlayerScoresRequestModel: Codable {
    var playerScores: [PlayerScores]
}

struct PlayerScores: Codable {
    var playerId: Int
    var score: Int
}
