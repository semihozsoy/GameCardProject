//
//  WishlistCollectionViewCell.swift
//  FinalProject
//
//  Created by Semih Özsoy on 31.05.2021.
//

import UIKit
import SDWebImage

class WishlistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var wishlistGameImage: UIImageView!
    @IBOutlet weak var wishlistGameNameLabel: UILabel!
    @IBOutlet weak var wishlistButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFontsandColors()
    }
    
    func configureCell(results: Result){
        wishlistGameNameLabel.text = results.name
        prepareGameImage(with: results.backgroundImage)
      
    }
    
    private func prepareGameImage(with urlString: String?){
        if let imageUrlString = urlString, let url = URL(string: imageUrlString){
            wishlistGameImage.sd_setImage(with: url)
        }
      
    }

    func configureFontsandColors(){
        wishlistView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        wishlistGameNameLabel.textColor = .white
        wishlistGameNameLabel.font = .medium(20)
        wishlistView.layer.cornerRadius = 5
        wishlistView.layer.masksToBounds = true
        wishlistButton.backgroundColor = UIColor(red: 93/255, green: 197/255, blue: 52/255, alpha: 1)
        wishlistButton.layer.cornerRadius = 5
        wishlistButton.layer.masksToBounds = true
    }


}
