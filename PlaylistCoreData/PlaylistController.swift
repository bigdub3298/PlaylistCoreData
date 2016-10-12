//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/12/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation

class PlaylistController {
    static let sharedController = PlaylistController()
    
    // Create 
    func addPlaylist(name: String) {
        let _ = addPlaylist(name)
        
        Stack.saveToPersistentStore()
    }
    
    // Remove
    func removePlaylist(playlist: Playlist) {
        if let moc = playlist.managedObjectContext {
            moc.deleteObject(playlist)
            Stack.saveToPersistentStore()
        }
    }
    
    // Add Song to playlist 
    func addSong(name: String, artist: String, playlist: Playlist) {
        let _ = Song(name: name, artist: artist, playlist: playlist)
        Stack.saveToPersistentStore()
    }
    
}