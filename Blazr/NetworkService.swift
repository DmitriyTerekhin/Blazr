//
//  NetworkService.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import Foundation

protocol INetworkService {
    func getCountry(ip: String?, completion: @escaping (Result<AppWayByCountry, NetworkError>) -> Void)
    func loadLink(completion: @escaping(Result<String, NetworkError>) -> Void)
    func makeAuth(code: String, completion: @escaping(Result<AuthModel, NetworkError>) -> Void)
    func makeAuth(token: String, completion: @escaping(Result<String, NetworkError>) -> Void)
}

class NetworkService: INetworkService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func getCountry(ip: String?, completion: @escaping (Result<AppWayByCountry, NetworkError>) -> Void) {
        completion(.success(.toApp))
    }
    func loadLink(completion: @escaping(Result<String, NetworkError>) -> Void) {
    }
    
    func makeAuth(code: String, completion: @escaping (Result<AuthModel, NetworkError>) -> Void) {}
    
    func makeAuth(token: String, completion: @escaping (Result<String, NetworkError>) -> Void) {}
}
