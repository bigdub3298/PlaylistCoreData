//
//  Playlist.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/11/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class Playlist: NSManagedObject {

    static let className = "Playlist"
    
    convenience init(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName(Playlist.className, inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
    }

}
