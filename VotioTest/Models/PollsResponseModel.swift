//
//  PollsResponseModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 4.04.24.
//

import Foundation

// MARK: - PollsResponseModel
struct PollsResponseModel: Codable {
    let success: Int
    let result: [Poll]
}

// MARK: - Result
struct Poll: Codable {
    let id: Int
    let subtitle: String
    let title, type, dateStart, dateEnd: String
    var isArchive: Int
    let playersVotingType: MatchResultsModel
}
