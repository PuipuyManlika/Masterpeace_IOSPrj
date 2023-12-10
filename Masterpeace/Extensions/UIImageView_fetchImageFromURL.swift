//
//  UIImageView_fetchImageFromURL.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit

extension UIImageView {
    
    func fetchUImageFromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}


