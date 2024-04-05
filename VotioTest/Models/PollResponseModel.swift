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
    let title, type, dateStart, dateEnd: String
    let isArchive: Int
    let playersVotingType: MatchResultsModel
    let playersVoting: [PlayersVoting]
    let stage: Int
}

// MARK: - PlayersVoting
struct PlayersVoting: Codable {
    let id: Int
    let name, number, amplua: String
    let photo: String
}

