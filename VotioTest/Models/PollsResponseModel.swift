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
    let result: [Polls]
}

// MARK: - Result
struct Polls: Codable {
    let id: Int
    let title, type, dateStart, dateEnd: String
    let isArchive: Int
    let playersVotingType: String
}
