//
//  UIFont+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/2/23.
//

import UIKit

enum FontWeight:String {
    case regular   = "Regular"
    case medium    = "Medium"
    case bold      = "Bold"
    case semibold  = "SemiBold"
    case light     = "Light"
    case black     = "Black"
}

extension UIFont {
    
    class func fixelText(size:CGFloat,weight:FontWeight) -> UIFont {
        return UIFont(name: "FixelText-\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
    
}
