//
//  CacheImage.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/5/21.
//

import UIKit

class CacheLikedPet {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cachedImagesModel = [LikedImage]()
    func getLikedImages(collection: UICollectionView? = nil) {
        
        
        do {
            cachedImagesModel = try context.fetch(LikedImage.fetchRequest())
            DispatchQueue.main.async {
                collection?.reloadData()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func saveLikedImage(petName: String, imageData: Data) {
        let newLikedImage = LikedImage(context: context)
        newLikedImage.petName = petName
        newLikedImage.isLiked = true
        newLikedImage.imageData = imageData
        
        do {
            try context.save()
            getLikedImages()
        } catch {
            print(error)
        }
    }
    
    func getCachedImageIndex(petName: String) -> Int? {
        getLikedImages()
        for (index, unlikedCat) in cachedImagesModel.enumerated() {
            if unlikedCat.petName == petName {
                return index
            }
        }
        return nil
    }
    
    func unlikeCachedImage(name: String) {
        getLikedImages()
        guard let index = getCachedImageIndex(petName: name) else { return }
        let catToBeUnliked = cachedImagesModel[index]
        deleteImageFromLikedCategory(likedImage: catToBeUnliked)
    }
    
    func isImageLiked(petName: String)->Bool {
        getLikedImages()
        if cachedImagesModel.contains(where: { likedImage in
            likedImage.petName == petName
        }) {
            return true
        }
        return false
        
    }
    
    func deleteImageFromLikedCategory(likedImage: LikedImage) {
        context.delete(likedImage)
        likedImage.isLiked = false
        do {
            try context.save()
            getLikedImages()

        } catch {
            print(error)
        }
    }
}

