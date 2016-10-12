//
//  Playlist+CoreDataProperties.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/11/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Playlist {

    @NSManaged var name: String?
    @NSManaged var songs: NSSet?

}
