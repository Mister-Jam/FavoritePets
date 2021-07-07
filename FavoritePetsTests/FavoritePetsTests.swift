//
//  FavoritePetsTests.swift
//  FavoritePetsTests
//
//  Created by King Bileygr on 7/3/21.
//

import XCTest
@testable import FavoritePets

class FavoritePetsTests: XCTestCase {
    
    var cachingLogic: CacheLikedPetViewModel!

    override func setUpWithError() throws {
        cachingLogic = CacheLikedPetViewModel()
        super.setUp()
    }

    override func tearDownWithError() throws {
        cachingLogic = nil
        super.tearDown()
    }
    
    func test_App_Caches_Liked_Pets() {
        let petName = "firstPet"
        let petImageData = petName.data(using: .utf8)!
     
        cachingLogic.saveLikedPet(petName: petName, imageData: petImageData)
        XCTAssertFalse(cachingLogic.cachedPetsModel.isEmpty)
        XCTAssertTrue(cachingLogic.cachedPetsModel.count >= 1)
        XCTAssertTrue(cachingLogic.cachedPetsModel.contains(where: { pet in
            pet.petName == petName
        }))
        cachingLogic.unlikeCachedPet(name: petName)
    }
    
    func test_App_Fetches_Cached_PetData() {
        var arr = [LikedImage]()
        XCTAssertTrue(arr.isEmpty)
        XCTAssertEqual(0, arr.count)
        
        let newPetName = "secondPet"
        let newPetImageData = newPetName.data(using: .utf8)!
     
        cachingLogic.saveLikedPet(petName: newPetName, imageData: newPetImageData)
        arr = cachingLogic.cachedPetsModel
        XCTAssertFalse(arr.isEmpty)
        XCTAssertTrue(arr.count >= 1)
        XCTAssertEqual(arr, cachingLogic.cachedPetsModel)
        cachingLogic.unlikeCachedPet(name: newPetName)
        
    }
    
    func test_App_Gets_Accurate_PetIndex() {
        
        let newPetName = "thirdPet"
        let newPetImageData = newPetName.data(using: .utf8)!
        
        cachingLogic.saveLikedPet(petName: newPetName, imageData: newPetImageData)
        let index = cachingLogic.getCachedPetIndex(petName: newPetName)
        XCTAssertEqual(newPetName, cachingLogic.cachedPetsModel[index!].petName)
        
        cachingLogic.unlikeCachedPet(name: newPetName)
    }
    

    
    func test_App_Deletes_From_Cache_Unliked_Pets() {
        let newPetName = "fourthPet"
        let newPetImageData = newPetName.data(using: .utf8)!
        let count = cachingLogic.cachedPetsModel.count
        XCTAssertEqual(count, cachingLogic.cachedPetsModel.count)
        XCTAssertFalse(cachingLogic.cachedPetsModel.contains(where: { pet in
            pet.petName == newPetName
        }))
        cachingLogic.saveLikedPet(petName: newPetName, imageData: newPetImageData)
        XCTAssertEqual(count + 1, cachingLogic.cachedPetsModel.count)
        XCTAssertTrue(cachingLogic.cachedPetsModel.contains(where: { pet in
            pet.petName == newPetName
        }))
        cachingLogic.unlikeCachedPet(name: newPetName)
        XCTAssertTrue(!cachingLogic.cachedPetsModel.contains(where: { pet in
            pet.petName == newPetName
        }))
        XCTAssertEqual(count, cachingLogic.cachedPetsModel.count)
        XCTAssertNil(cachingLogic.getCachedPetIndex(petName: newPetName))
        
    }

}
