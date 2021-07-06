//
//  ViewModel.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/4/21.
//

import UIKit

class AllPetsViewModel {

    var catName: String
    var imageUrl: String?
    var isLiked: Bool = false
   
    init( name: String, imageUrl: String, likeStatus: Bool) {
        catName         = name
        self.imageUrl   = imageUrl
        isLiked         = likeStatus
    }
    ///Download image data and load image
    func downloadImage(imageView: UIImageView, success: @escaping ((Data)->Void) ) {
        guard let imageUrl      = imageUrl,
              let url           = URL(string: imageUrl) else { return }
        
        URLSession.shared.getData(url: url) { result in
            switch result {
            
            case .success(let data):
                DispatchQueue.main.async {
                    imageView.image     = UIImage(data: data)
                }
                success(data)
            case .failure(_):
                break
            }
        }
    }
}
