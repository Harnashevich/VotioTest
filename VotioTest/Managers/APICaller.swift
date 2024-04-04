//
//  APICaller.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 4.04.24.
//


import Alamofire
import UIKit

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    private struct Constents {
        static let baseURL = "http://vt.lab42.pro"
        static let appToken = "eRwbD24t435gfwqefgc3"
        static var uIDevice: String {
            guard let uIDevice = UIDevice.current.identifierForVendor?.uuidString else {
                return String()
            }
            return uIDevice
        }
    }
    
    private struct Endpoints {
        static let hello = "/api/v1.0/hello"
        static let getPolls = "/api/v1.0/get-polls"
        static let getPoll = "/api/v1.0/get-poll/"
        static let getPlayer = "/api/v1.0/get-player/"
    }
    
}

//MARK: - API public methods

extension APICaller {
    
    func getHello(completion: @escaping (Result<HelloResponseModel, Error>) -> Void) {
        createRequest(
            path: Endpoints.hello,
            method: .get,
            headers: ["App-Token": "\(Constents.appToken)"]
        ) { (result: Result<HelloResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPolls(completion: @escaping (Result<PollsResponseModel, Error>) -> Void) {
        createRequest(
            path: Endpoints.getPolls,
            method: .get,
            headers: [
                "App-Token": "\(Constents.appToken)",
                "Uuid": "\(Constents.uIDevice)"
            ]
        ) { (result: Result<PollsResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPoll(
        id: Int,
        completion: @escaping (Result<PollResponseModel, Error>) -> Void
    ) {
        createRequest(
            path: Endpoints.getPoll + "\(id)",
            method: .get,
            parameters: [
                "id": id
            ],
            headers: [
                "App-Token": "\(Constents.appToken)",
                "Uuid": "\(Constents.uIDevice)"
            ]
        ) { (result: Result<PollResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPlayer(
        id: Int,
        completion: @escaping (Result<PlayerResponseModel, Error>) -> Void
    ) {
        createRequest(
            path: Endpoints.getPlayer + "\(id)",
            method: .get,
            parameters: [
                "id": id
            ],
            headers: [
                "App-Token": "\(Constents.appToken)",
                "Uuid": "\(Constents.uIDevice)"
            ]
        ) { (result: Result<PlayerResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//MARK: - API private methods

extension APICaller {
    
    private func createRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping ((Result<T, Error>)) -> Void
    ) {
        print("URL \(Constents.baseURL + path)")
        
        AF.request(
            Constents.baseURL + path,
            method: method,
            parameters: parameters,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
