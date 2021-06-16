//
//  StampView.swift
//  FinalProject
//
//  Created by Semih Özsoy on 6.06.2021.
//

import UIKit

final class StampView: NibView{
    @IBOutlet weak var visitLabel: UILabel!
    
   public func configure(title:String,
                   titleColor:UIColor = .white,
                   titleFont:UIFont = .regular(14)) {
        visitLabel.text = title
    }
    
}
