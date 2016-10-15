//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/12/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    static let sharedController = PlaylistController()
    
    var playlists: [Playlist] {
        let request = NSFetchRequest(entityName: Playlist.className)
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            return try moc.executeFetchRequest(request) as! [Playlist]
        } catch {
            return []
        }
    }
    // Create 
    func addPlaylist(name: String) {
        let _ = Playlist(name: name)
        
        Stack.saveToPersistentStore()
    }
    
    // Remove
    func removePlaylist(playlist: Playlist) {
        if let moc = playlist.managedObjectContext {
            moc.deleteObject(playlist)
            Stack.saveToPersistentStore()
        }
    }
    
    // Add Song
    func addSongToPlaylist(name: String, artist: String, playlist: Playlist) {
        let _ = Song(name: name, artist: artist, playlist: playlist)
        
        Stack.saveToPersistentStore()
    }
    
    // Remove Song
    func removeSongFromPlaylist(song: Song) {
        if let moc = song.managedObjectContext {
            moc.deleteObject(song)
            Stack.saveToPersistentStore()
        }
    }
    
}