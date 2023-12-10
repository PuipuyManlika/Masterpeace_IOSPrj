//
//  Helper.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-04-05.
//

import UIKit
import SDWebImage

class Helper {
    
    static func newLabel (defaultText : String, textColor : UIColor, fontSize : CGFloat, fontAttribute : UIFont.Weight, textAlignment : NSTextAlignment) -> UILabel {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = defaultText
        lbl.textAlignment = textAlignment
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: fontSize, weight: fontAttribute)
        lbl.textColor = textColor
        
        return lbl
    }
    
    static func newTextField (placeHolder : String, isPassword : Bool) -> UITextField {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = UIColor(red: 245/255, green: 237/255, blue: 224/255, alpha: 1)
        txt.textColor = .black
        txt.font = .systemFont(ofSize: 20)
        txt.textAlignment = .left
        txt.placeholder = placeHolder
        txt.isSecureTextEntry = isPassword
        
        return txt
    }
    
    static func newButton (title : String, backgroundColor: UIColor, titlecolor: UIColor, radius: CGFloat? = nil) -> UIButton {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titlecolor, for: .normal)
        btn.backgroundColor = backgroundColor
        if radius != nil{
            btn.layer.cornerRadius = radius!
        }
       
        
        return btn
    }
    
    static func newImage (imgName: String? = nil, tintColor: UIColor ,transform: CGFloat? = nil, contentMode: UIView.ContentMode, sd_imageIndicator: SDWebImageIndicator? = nil) -> UIImageView  {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = tintColor
        img.contentMode = contentMode
        
        if imgName != nil{
            img.image = UIImage(named: imgName!)
        }
        
        if transform != nil {
            img.transform = img.transform.rotated(by: CGFloat(transform!)) // 45 degree
        }
        
        if sd_imageIndicator != nil{
            img.sd_imageIndicator = sd_imageIndicator!
        }
        
        return img
    }
}
