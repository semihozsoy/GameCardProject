//
//  PlatformsView.swift
//  FinalProject
//
//  Created by Semih Özsoy on 6.06.2021.
//

import UIKit

final class PlatformsView: NibView{
    @IBOutlet weak var platformsLabel: UILabel!
    
    public func configure(title:String,
                    titleColor:UIColor = .white,
                    titleFont:UIFont = .regular(10)) {
         platformsLabel.text = title
        
     }
}
