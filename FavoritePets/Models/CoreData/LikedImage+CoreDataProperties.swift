//
//  LikedImage+CoreDataProperties.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/5/21.
//
//

import Foundation
import CoreData


extension LikedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedImage> {
        return NSFetchRequest<LikedImage>(entityName: "LikedImage")
    }

    @NSManaged public var petName: String?
    @NSManaged public var isLiked: Bool
    @NSManaged public var imageData: Data?

}

extension LikedImage : Identifiable {

}
