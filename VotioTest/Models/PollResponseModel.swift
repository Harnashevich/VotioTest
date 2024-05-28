//
//  PollResponseModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 4.04.24.
//

import Foundation

// MARK: - PollResponseModel
struct PollResponseModel: Codable {
    let success: Int
    let result: PollDetails
}

// MARK: - Result
struct PollDetails: Codable {
    let id: Int
    let subtitle: String
    let title, type, dateStart, dateEnd: String
    let isArchive: Int
    let playersVotingType: MatchResultsModel
    let playersVoting: [PlayerVoting]
    let playersVotingStats: [PlayerVoting]
    let stage: Int
}

// MARK: - PlayersVoting
struct PlayerVoting: Codable {
    let id: Int
    let name, number, amplua: String
    let photo: String
    let score: Double?
    let voters: Int?
}
