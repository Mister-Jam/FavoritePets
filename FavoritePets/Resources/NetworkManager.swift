//
//  NetworkManager.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/4/21.
//

import Foundation

final class NetworkManager {
    
    static let shared   = NetworkManager()
    
    private let path    = "v1/breeds"
    //MARK: Pass in URL and get a decoded Data
    public func getCatsData(completion: @escaping ((Result<[CatsDataModel], Error>)->Void)) {
        guard let urlrequest = URL(string: Constants.UrlConstants.baseUrl+path) else { return }
        URLSession.shared.decodeData(from: urlrequest, type: [CatsDataModel].self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
