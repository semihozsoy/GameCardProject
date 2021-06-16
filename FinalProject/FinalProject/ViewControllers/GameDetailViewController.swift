//
//  GameDetailViewController.swift
//  FinalProject
//
//  Created by Semih Özsoy on 31.05.2021.
//

import UIKit
import CoreApi

class GameDetailViewController: UIViewController {
    @IBOutlet weak var gameDetailImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var informationsLabel: UILabel!
    @IBOutlet weak var releaseDateShowLabel: UILabel!
    @IBOutlet weak var genresShowLabel: UILabel!
    @IBOutlet weak var playTimeShowLabel: UILabel!
    @IBOutlet weak var publishersShowLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var visitView: StampView!
    @IBOutlet weak var visitWebView: StampView!
    
    
    public var id : Int?
    private var infoCells: [[String:String]] = []
    let networkManager: NetworkManager<GameEndpointItem> = NetworkManager()
    private var details:DetailResults?
    private var results:[Result]? = []
    private var genres:[DetailDeveloper]?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
   
    
    func fetchResults(id: Int) {
        networkManager.request(endpoint:.details(id:id), type: DetailResults.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.details = response
                self?.configureViews()
                self?.configureImage()
             
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func configureViews(){
        gameNameLabel.text = details?.name
        descriptionTextView.text = details?.descriptionRaw
        releaseDateLabel.text = details?.released
        playTimeLabel.text = details?.playtime?.description
        ratingLabel.text = details?.metacritic?.description
        prepareGenres(genresDetail: details)
        preparePublishers(publishersDetail: details)
        gameDetailImageView.layer.cornerRadius = 5
        gameDetailImageView.layer.masksToBounds = true
        gameNameLabel.font = .semibold(20)
        gameNameLabel.textColor = .white
        descriptionLabel.font = .semibold(16)
        descriptionLabel.textColor = .white
        descriptionTextView.font = .regular(12)
        descriptionTextView.backgroundColor = UIColor(hex: "292929")
        descriptionTextView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        descriptionView.backgroundColor = UIColor(hex: "292929")
        informationsLabel.font = .semibold(16)
        informationsLabel.textColor = .white
        releaseDateLabel.font = .regular(10)
        releaseDateShowLabel.font = .regular(10)
        releaseDateShowLabel.textColor = UIColor(hex: "119119119")
        playTimeLabel.font = .regular(10)
        playTimeShowLabel.font = .regular(10)
        playTimeShowLabel.textColor = UIColor(hex: "119119119")
        informationView.backgroundColor = UIColor(hex: "292929")
        publisherLabel.font = .regular(10)
        publishersShowLabel.font = .regular(10)
        publishersShowLabel.textColor = UIColor(hex: "119119119")
        genresLabel.font = .regular(10)
        genresShowLabel.font = .regular(10)
        genresShowLabel.textColor = UIColor(hex: "119119119")
        ratingLabel.layer.borderWidth = 1
        ratingLabel.layer.cornerRadius = 5
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.borderColor = CGColor(red: 93/255, green: 197/255, blue: 52/255, alpha: 1)
        ratingLabel.textColor = UIColor(red: 93/255, green: 197/255, blue: 52/255, alpha: 1)
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.masksToBounds = true
        informationView.layer.cornerRadius = 10
        informationView.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        let webTap = UITapGestureRecognizer(target: self, action: #selector(handleWebTap))
        visitView.addGestureRecognizer(tap)
        visitWebView.addGestureRecognizer(webTap)
        visitView.configure(title: "Visit Reddit")
        visitWebView.configure(title: "Visit Web")
   
    }
    @objc func handleTap(){
        if let url = URL(string: details?.redditURL ?? ""){
            UIApplication.shared.open(url)
        }
  
        
    }
    @objc func handleWebTap(){
        if let url = URL(string: details?.website ?? "") {
            UIApplication.shared.open(url)
        }
        
    }
    
    func configureImage(){
        let urlString = details?.backgroundImage
        if let imageUrlString = urlString,let url = URL(string: imageUrlString){
            gameDetailImageView.sd_setImage(with: url)
        }
    }
    
    private func preparePublishers(publishersDetail:DetailResults?){
        var publishersArray: [String]?
        if let publishers = publishersDetail?.publishers{
            publishersArray = publishers.map{$0.name}
        }
        guard let publishersDict = publishersArray?.joined(separator: ", ") else {return}
        infoCells.append(["Publishers: ":publishersDict])
        publisherLabel.text = "\(publishersDict)"
        
    }
    
    private func prepareGenres(genresDetail: DetailResults?) {
        
        var genresArray: [String]?
        if let genres = genresDetail?.genres {
            genresArray = genres.map { $0.name }
        }
        guard let genresDict = genresArray?.joined(separator: ", ") else { return }
        infoCells.append(["Genres: ":genresDict])
       genresLabel.text = "\(genresDict)"
        
    }
    
}
