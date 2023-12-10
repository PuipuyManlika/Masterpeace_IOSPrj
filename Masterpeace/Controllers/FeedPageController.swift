//
//  FeedPageController.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedPageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    var songs: [Song] = []
    
    var selectedRow : Int?
    
    let tableView : UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase
        ref = Database.database().reference()
        
        //To add data to the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MySongTableViewCell.self, forCellReuseIdentifier: "mySongCell")
        
        self.view.addSubviews(tableView)
        
        applyConstraint()
        
        ref.child("songs").observe(.value) { snapshot in
            
            self.songs = []
            
            if let values = snapshot.value as? NSDictionary {
                
                for (uid, data) in values {
                    
                    let content = data as! [String: Any]
                    self.songs.append( Song(title: content["title"] as! String, imgIcon : content["imgIcon"] as! String, imgBackground: content["imgBackground"] as! String, songUrl: content["songUrl"] as! String))
                    
                }
                
            }
            
            self.tableView.reloadData()
            
        }
}
    
    func applyConstraint() {
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySongCell", for: indexPath) as! MySongTableViewCell
        
        let song = songs[indexPath.row]
        
        cell.setContent( song: song )
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count //the number of songs we have
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        
        performSegue(withIdentifier: "toSongPageController", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSongPageController" {
            
            let songPageController = segue.destination as! SongPageController
            
            songPageController.seletedSong = songs[selectedRow!]
            
        }
    }
}
