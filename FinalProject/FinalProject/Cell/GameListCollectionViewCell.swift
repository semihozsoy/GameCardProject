//
//  GameCollectionViewCell.swift
//  FinalProject
//
//  Created by Semih Özsoy on 31.05.2021.
//

import UIKit

class GameListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wishButton: UIButton!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var descriptionViewContainer: UIView!
    @IBOutlet weak var gameListView: UIView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var generesLabel: UILabel!
    @IBOutlet weak var platformView: PlatformsView!
    
    @IBOutlet weak var playTimeLabel: UILabel!
    private var infoCells: [[String:String]] = []
    public var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellSize()
        configureFontsandColor()
        configureButton()
    
    }
    
    func configureCell(game: Result){
        
        gameNameLabel.text = game.name
        ratingLabel.text = String(game.metacritic ?? 0)
        releaseDateLabel.text = "Release Date:\(game.released!)"
        playTimeLabel.text = "Play Time:\(String(game.playtime ?? 0))"
        prepareGameImage(with: game.backgroundImage)
        generesLabel.text = ""
        prepareGenres(game: game)
        descriptionViewContainer.layer.backgroundColor = CGColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        id = game.id
    }
    
    func platformConfigure(parentPlatforms: [ParentPlatform]){
        var tempLabel = ""
        for platform in parentPlatforms {
            tempLabel.append("\(platform.platform?.name ?? "")" )
            
        }
        
        self.platformView.configure(title: tempLabel)
        platformView.layer.cornerRadius = 4
        platformView.layer.masksToBounds = true
        platformView.backgroundColor = UIColor(hex: "454545")
        self.platformLabel.text = tempLabel
    }

    func configureFontsandColor(){
        gameNameLabel.font = .medium(20)
        releaseDateLabel.font = .regular(10)
        generesLabel.font = .regular(10)
        playTimeLabel.font = .regular(10)
        platformLabel.font = .regular(10)
        gameNameLabel.textColor = .white
        releaseDateLabel.textColor = .white
        generesLabel.textColor = .white
        playTimeLabel.textColor = .white
        ratingLabel.textColor = UIColor(red: 93/255, green: 197/255, blue: 52/255, alpha: 1)
        ratingLabel.layer.borderWidth = 1
        ratingLabel.layer.borderColor = CGColor(red: 93/255, green: 197/255, blue: 52/255, alpha: 1)
        ratingLabel.layer.backgroundColor =  CGColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        ratingLabel.font = .regular(10)
    }
    
    func configureButton(){
        wishButton.backgroundColor = UIColor(hex: "292929")
        wishButton.layer.cornerRadius = 5
        wishButton.layer.masksToBounds = true
        wishButton.layer.borderWidth = 1
        
    }
    
    private func prepareGenres(game: Result) {
        
        var genresArray: [String]?
        if let genres = game.genres {
            genresArray = genres.map { $0.name! }
        }
        guard let genresDict = genresArray?.joined(separator: ", ") else { return }
        infoCells.append(["Genres: ":genresDict])
        generesLabel.text = "Genres:\(genresDict)"
       
        
    }
 
    private func prepareGameImage(with urlString: String?){
        if let  imageUrlString = urlString, let url = URL(string: imageUrlString){
            gameImageView.sd_setImage(with: url)
        }
    }
    
    func configureCellSize(){
     
        gameListView.layer.cornerRadius = 16
        gameListView.layer.masksToBounds = true
        gameListView.layer.borderWidth = 1
        
    }
  
}
