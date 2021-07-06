//
//  CatsDataModel.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/4/21.
//

import Foundation

struct CatsDataModel: Decodable {
   
    var image: ImageModel?
    var name: String
}

struct ImageModel: Codable {
    
    var url: String?
}
