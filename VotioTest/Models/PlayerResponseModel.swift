//
//  PlayerResponseModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 4.04.24.
//

import Foundation

// MARK: - PlayerResponseModel
struct PlayerResponseModel: Codable {
    let success: Int
    let result: Player
}

// MARK: - Result
struct Player: Codable {
    let id: Int
    let name, number, amplua: String
    let photo: String
}
