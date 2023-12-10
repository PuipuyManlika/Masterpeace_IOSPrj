//
//  MySongTableViewCell.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-31.
//

import UIKit


class MySongTableViewCell : UITableViewCell {
        
    public var imageUrl : String? {
        didSet{
            self.newImage.fetchUImageFromURL(url: URL(string: imageUrl!)!)
        }
    }
    
    private let newImage = Helper.newImage(tintColor: UIColor.gray, contentMode: UIView.ContentMode.scaleAspectFit)
    
    private let lblTitle = Helper.newLabel(defaultText: "", textColor: UIColor.black, fontSize: 22, fontAttribute: UIFont.Weight.regular, textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
        applyConstraint()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(){
        
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 208/255, alpha: 1)
        addSubviews(lblTitle, newImage)
        
    }
    
    func applyConstraint() {
        
        NSLayoutConstraint.activate([
            
            newImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -80),
            newImage.heightAnchor.constraint(equalToConstant: 100),
            newImage.widthAnchor.constraint(equalToConstant: 80),
            newImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            lblTitle.heightAnchor.constraint(equalToConstant: 100),
            lblTitle.widthAnchor.constraint(equalToConstant: 180),
            lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
    
    public func setContent( song : Song ) {
        
        lblTitle.text = song.title
        self.imageUrl = song.imgIcon
        
    }
    
    
    
}
