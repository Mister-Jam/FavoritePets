//
//  CacheImage.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/5/21.
//

import UIKit

class CacheLikedPetViewModel {
    
    private let context     = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cachedPetsModel     = [LikedImage]()
    
    ///Fetches all items in the database
    func getLikedPets(collection: UICollectionView? = nil) {
        do {
            cachedPetsModel = try context.fetch(LikedImage.fetchRequest())
            DispatchQueue.main.async {
                collection?.reloadData()
            }
        } catch {
            debugPrint(error)
        }
    }
    ///Save a liked pet by creating a new entry in the database
    func saveLikedPet(petName: String, imageData: Data) {
        let newLikedPet         = LikedImage(context: context)
        newLikedPet.petName     = petName
        newLikedPet.isLiked     = true
        newLikedPet.imageData   = imageData
        
        do {
            try context.save()
            getLikedPets()
        } catch {
            print(error)
        }
    }
    ///Gets the index of a pet in the database
    func getCachedPetIndex(petName: String) -> Int? {
        getLikedPets()
        for (index, unlikedCat) in cachedPetsModel.enumerated() {
            if unlikedCat.petName == petName {
                return index
            }
        }
        return nil
    }
    ///Gets the index of a pet in the database and delete it after unliking it
    func unlikeCachedPet(name: String) {
        getLikedPets()
        guard let index = getCachedPetIndex(petName: name) else { return }
        let catToBeUnliked = cachedPetsModel[index]
        deletePetFromLikedCategory(likedPet: catToBeUnliked)
    }
    
    ///Delete a pet from the database
    func deletePetFromLikedCategory(likedPet: LikedImage) {
        context.delete(likedPet)
        likedPet.isLiked = false
        do {
            try context.save()
            getLikedPets()

        } catch {
            print(error)
        }
    }
}

