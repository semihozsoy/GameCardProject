//
//  PlatformCollectionViewCell.swift
//  FinalProject
//
//  Created by Semih Özsoy on 1.06.2021.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var platformView: UIView!
    @IBOutlet weak var platformLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
    }
    
     func configureCell(platform: PlatformResult){
        platformLabel.text = platform.name
      
        
    }
    
    func configure(){
        platformLabel.font = .regular(14)
        platformLabel.textColor = .white
        platformView.backgroundColor = UIColor(hex: "454545")
        platformView.layer.borderWidth = 1
        platformView.layer.cornerRadius = 5
        platformView.layer.masksToBounds = true
        
    }

}
