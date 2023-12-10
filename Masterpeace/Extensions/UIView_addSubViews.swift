//
//  UIView_addSubViews.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit

extension UIView{
    
    //Variadic function
    func addSubviews( _ views : UIView... ){
        
        for view in views{
            self.addSubview(view)
        }
    }
}
