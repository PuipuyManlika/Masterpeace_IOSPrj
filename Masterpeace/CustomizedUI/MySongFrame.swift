//
//  FeedPage.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit
import SDWebImage

class MySongFrame : UIView {
    
    public var imageUrl : String? {
        didSet{
            self.newImage.fetchUImageFromURL(url: URL(string: imageUrl!)!)
        }
    }
    
    let newImage = Helper.newImage(tintColor: UIColor.gray, contentMode: UIView.ContentMode.scaleAspectFill, sd_imageIndicator: SDWebImageActivityIndicator.grayLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
        applyConstraint()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(){
        
        addSubview(newImage)
        
    }
    
    func applyConstraint() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 1000),
            self.widthAnchor.constraint(equalToConstant: 400),
            
            newImage.topAnchor.constraint(equalTo: self.topAnchor),
            newImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    public func setContent( song : Song ) {
        
        self.imageUrl = song.imgBackground
        
    }
    
}
