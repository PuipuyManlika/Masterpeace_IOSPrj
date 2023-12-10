//
//  SongPageController.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-31.
//

import UIKit
import Firebase
import AVKit
import SDWebImage

class SongPageController: UIViewController{

    var seletedSong : Song?
    
    var ref: DatabaseReference!
    
    var player: AVPlayer?
    
    let mySongFrame = MySongFrame()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        applyConstraint()

    }
    
    func initialize(){
        
        self.view.addSubview(mySongFrame)
        
        //to make the moving background in MySongFrame
        let url = URL(string: (seletedSong?.imgBackground)!)
        mySongFrame.newImage.sd_setImage(with: url, completed: nil)

        guard let url = URL(string: (seletedSong?.songUrl)!) else { return }
        
        // Create an AVPlayerItem with the audio file URL
        let playerItem = AVPlayerItem(url: url)
               
        // Create an AVPlayer with the AVPlayerItem
        player = AVPlayer(playerItem: playerItem)
               
        // Start playing the audio file
        player?.play()
        

    }
    
    func applyConstraint(){
        
        NSLayoutConstraint.activate([
            
            mySongFrame.topAnchor.constraint(equalTo: self.view.topAnchor),
            mySongFrame.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mySongFrame.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mySongFrame.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
  
            
        ])
        
    }
    
}
