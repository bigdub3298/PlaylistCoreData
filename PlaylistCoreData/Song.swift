//
//  Song.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/11/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class Song: NSManagedObject {

    static let className = "Song"
    
    convenience init(name: String, artist: String, playlist: Playlist, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName(Song.className, inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.artist = artist
        self.playlist = playlist
    }

}
