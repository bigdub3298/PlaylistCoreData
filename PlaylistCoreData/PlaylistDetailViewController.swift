//
//  PlaylistDetailViewController.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/12/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class PlaylistDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        guard let playlist = playlist else { return }
        
        updateWithPlaylist(playlist)
        addButton.enabled = false 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let songSet = playlist?.songs,
            let songs = Array(songSet) as? [Song] else { return 0 }
        
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath)
        
        guard let songSet = playlist?.songs,
            let songs = Array(songSet) as? [Song] else { return cell }
        
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let songSet = playlist?.songs,
                let songs = Array(songSet) as? [Song] else { return }
            
            let selectedSong = songs[indexPath.row]
            PlaylistController.sharedController.removeSongFromPlaylist(selectedSong)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Text Field Delegate 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if  !(textField.text?.isEmpty)! {
            addButton.enabled = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        let songName = songTextField.text ?? ""
        let artistName = artistTextField.text ?? "" 
        
        guard let playlist = playlist,
        let songSet = playlist.songs else { return }
        
        let newIndexPath = NSIndexPath(forRow: songSet.count, inSection: 0)
        
        PlaylistController.sharedController.addSongToPlaylist(songName, artist: artistName, playlist: playlist)
        
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        
        // update view elements
        addButton.enabled = false
        songTextField.text = ""
        artistTextField.text = ""
    }
    
    
    // MARK: - Helper functions
    
    func updateWithPlaylist(playlist: Playlist) {
        self.navigationItem.title = playlist.name
    }

}
