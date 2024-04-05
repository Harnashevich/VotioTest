//
//  MatchResultsModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 5.04.24.
//

enum MatchResultsModel: String, Codable {
    case lose
    case draw
    case win
    
    var scores: [Int] {
        switch self {
        case .lose:
            return [-10, -9, -8, -7, -6, -5, -4, 1, 2, 3]
        case .draw:
            return  [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5]
        case .win:
            return [-3, -2, -1, 4, 5, 6, 7, 8, 9, 10]
        }
    }
}
