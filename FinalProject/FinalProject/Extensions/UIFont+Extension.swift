//
//  UIFont+Extension.swift
//  FinalProject
//
//  Created by Semih Özsoy on 4.06.2021.
//

import UIKit

extension UIFont {    
    public static func medium(_ size: Int)->UIFont {
      return UIFont(name: "SFProDisplay-Medium", size: CGFloat(size))!
    }
    
    public static func regular(_ size: Int)->UIFont {
       return UIFont(name: "SFProDisplay-Regular", size: CGFloat(size))!
    }
    
    public static func semibold(_ size: Int)->UIFont {
        return UIFont(name: "SFProText-Semibold", size: CGFloat(size))!
    }
    
    public static func bold(_ size: Int)->UIFont {
        return UIFont(name: "SFProText-Bold", size: CGFloat(size))!
    }
}
