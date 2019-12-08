//
//  Dogs+CoreDataProperties.swift
//  konfioExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/7/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//
//

import Foundation
import CoreData


extension Dogs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dogs> {
        return NSFetchRequest<Dogs>(entityName: "Dogs")
    }

    @NSManaged public var dogName: String?
    @NSManaged public var dogDescription: String?
    @NSManaged public var dogAge: Int16
    @NSManaged public var dogUrl: String?

}
