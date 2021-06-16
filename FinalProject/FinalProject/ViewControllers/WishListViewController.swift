//
//  WhisListViewController.swift
//  FinalProject
//
//  Created by Semih Özsoy on 31.05.2021.
//

import UIKit
import CoreApi

class WishListViewController: UIViewController {
    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    let networkManager: NetworkManager<GameEndpointItem> = NetworkManager()
    private var results:[Result]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        fetchResults()
    }
    
    func prepareCollectionView(){
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        wishlistCollectionView.register(cellType: WishlistCollectionViewCell.self)
    }
    
    fileprivate func fetchResults() {
        networkManager.request(endpoint:.gamepage(query: "cyberpunk") , type: Results.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.results = response.results
                self?.wishlistCollectionView.reloadData()
                break
            case .failure(let error):
                break
            }
        }
    }
    
    

}


extension WishListViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType:WishlistCollectionViewCell.self,indexPath: indexPath) 
        if let games = results?[indexPath.item] {
            cell.configureCell(results: games)
        }
        return cell
    }
    
    
}
