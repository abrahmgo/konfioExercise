//
//  FavoriteDogs+CoreDataProperties.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteDogs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteDogs> {
        return NSFetchRequest<FavoriteDogs>(entityName: "FavoriteDogs")
    }

    @NSManaged public var dogUrl: String?

}
