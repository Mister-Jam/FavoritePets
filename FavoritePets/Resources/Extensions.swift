//
//  Extensions.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

extension UIView {
    //MARK: Add Multiple Objects to the Views Subview at Once
    func addSub(views: [UIView] ) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}

extension URLSession {
    //MARK: Get Data From a URL Session
    func getData(url: URL, completion: @escaping ((Result<Data, Error>)->Void) ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(DecodingErrors.failedToFetchData))
                return }
            completion(.success(data))
    
        }.resume()
    }
    
    //MARK: Decode Data Gotten From a URL Session
    func decodeData<T: Decodable> (from url: URL, type: T.Type,
                                   keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy     = .useDefaultKeys,
                                   dataDecodingStrategy: JSONDecoder.DataDecodingStrategy   = .deferredToData,
                                   completion: @escaping ((Result<T, Error>)->Void)
    ) {
        self.getData(url: url) { result in
            switch result {
            case .success(let data):
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = keyDecodingStrategy
                decoder.dataDecodingStrategy    = dataDecodingStrategy
                do {
                    let decodededData           = try decoder.decode(T.self, from: data)
                    completion(.success(decodededData))
                } catch {
                    completion(.failure(error))
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    enum DecodingErrors: String, Error {
        case failedToFetchData = "Unable to fetch data from the web....Check your network and try again"
    }
    
}
//MARK: Notifications for Liking and Unliking a Pet
extension Notification.Name {
    static let didUnlikeCat     = Notification.Name("didUnlikeCat")
    static let didLikeCat       = Notification.Name("didLikeCat")
}
