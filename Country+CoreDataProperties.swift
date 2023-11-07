//
//  Country+CoreDataProperties.swift
//  TableViews
//
//  Created by Daniel Felipe on 28/10/23.
//  Copyright © 2023 MoureDev. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?

}
