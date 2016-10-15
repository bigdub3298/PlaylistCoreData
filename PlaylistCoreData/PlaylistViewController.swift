//
//  PlaylistViewController.swift
//  PlaylistCoreData
//
//  Created by Wesley Austin on 10/12/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        addButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - Table View Datasoure 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.sharedController.playlists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playlistCell", forIndexPath: indexPath)
        
        let playlist = PlaylistController.sharedController.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.name
        guard let songs = playlist.songs else { return cell }
        
        cell.detailTextLabel?.text = "\(songs.count) songs"
        
        return cell
    }
    
    // MARK: - Table View Delegate 
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let playlist = PlaylistController.sharedController.playlists[indexPath.row]
            PlaylistController.sharedController.removePlaylist(playlist)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if !(nameTextField.text?.isEmpty)! {
            addButton.enabled = true
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPlaylistDetailView" {
            guard let playlistDetailViewContoller = segue.destinationViewController as? PlaylistDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let selectedPlaylist = PlaylistController.sharedController.playlists[indexPath.row]
            
            playlistDetailViewContoller.playlist = selectedPlaylist
        }
    }

    // MARK: - Actions 
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        let playlistName = nameTextField.text ?? ""
        
        let newIndexPath = NSIndexPath(forRow: PlaylistController.sharedController.playlists.count, inSection: 0)
        
        PlaylistController.sharedController.addPlaylist(playlistName)
        
        
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        
        // update view elements
        addButton.enabled = false
        nameTextField.text = ""
    }
    
}
