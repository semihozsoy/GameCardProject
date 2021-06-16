//
//  ViewController.swift
//  FinalProject
//
//  Created by Semih Özsoy on 29.05.2021.
//

import UIKit
import CoreApi

class GameListViewController: UIViewController {
 
    let networkManager: NetworkManager<GameEndpointItem> = NetworkManager()
    private var gameCollectionView:UICollectionView!
    private var results: [Result]? = []
    private var platformResult: [PlatformResult]? = []
    private var layoutSize = 1.0
    private var headerSize = 0.3
    private var details: [DetailResults]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResults()
        prepareGameCollectionView()
        fetchPlatform()
        prepareSearchController()
        prepareNavigationBarUI()
    }
    
    func prepareGameCollectionView(){
        gameCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        view.addSubview(gameCollectionView)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(cellType: GameListCollectionViewCell.self)
        gameCollectionView.register(cellType: PlatformCollectionViewCell.self)
     
    }
    
    @IBAction func changeCellTypeButtonTapped(_ sender: Any) {
       
    }
    
    private func prepareSearchController(){
        let searchSuggestionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameListViewController")
            
            let searchController = UISearchController(searchResultsController: searchSuggestionVC)
            let searchBar = UISearchBar()
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.tintColor = .cyan
            searchController.searchBar.searchTextPositionAdjustment = .init(horizontal:10,vertical: 0)
            searchController.searchBar.delegate = self
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Vazgeç"
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.cyan
         
            navigationItem.searchController = searchController
        
        
    }
    
    private func prepareNavigationBarUI(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 0.94)
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    
    fileprivate func fetchResults() {
        networkManager.request(endpoint:.gamepage(query: "") , type: Results.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.results = response.results
                self?.gameCollectionView.reloadData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        
    }
    
    
    fileprivate func fetchPlatform(){
        networkManager.request(endpoint:.platform , type: PlatformResults.self) { result in
            switch result {
            case .success(let response):
                self.platformResult = response.results
                
                self.gameCollectionView.reloadData()
                break
            case .failure(let error):
                break
            }
        }
    }
    
    
    fileprivate func fetchForSearch(text:String){
        networkManager.request(endpoint:.search(text:text) , type: Results.self) { result in
            switch result {
            case .success(let response):
                self.results = response.results
                self.gameCollectionView.reloadData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    
}

extension GameListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return platformResult?.count ?? .zero
        }else {
            return results?.count ?? .zero
        }
    
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeCell(cellType:PlatformCollectionViewCell.self,indexPath: indexPath)
            if let platforms = platformResult?[indexPath.row]{
                cell.configureCell(platform: platforms)
            }
        
           
            return cell
        }
        else {
            let cell = collectionView.dequeCell(cellType:GameListCollectionViewCell.self,indexPath: indexPath)
            if let games = results?[indexPath.item] {
                cell.configureCell(game:games)
                cell.platformConfigure(parentPlatforms: games.parentPlatforms!)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "gameDetailVC") as? GameDetailViewController {
                vc.id = results?[indexPath.item].id
                vc.fetchResults(id:(results?[indexPath.item].id)!)
                self.present(vc, animated: true, completion: nil)
            }
        }
        else {
            // filtreleme yapmak lazım burda.
//            filteredData = allData.filter({ (platforms:PlatformResults)->Bool in
//                return platforms.results.lowercased().contains(platforms) ?? false
//            })
//            isFiltering = true
        }
     
    }
}

extension GameListViewController {
    func createLayout()->UICollectionViewLayout {
        UICollectionViewCompositionalLayout {sectionIndex, _ in
            if sectionIndex == 0 {
                return self.makeHorizontalLayout()
            }
            if sectionIndex == 1 {
                return self.makeVerticalLayout()
            }
            return self.makeVerticalLayout()
        }
    }
}

extension GameListViewController{
    func makeHorizontalLayout()->NSCollectionLayoutSection{
  
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

extension GameListViewController {
    func makeVerticalLayout()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
}


extension GameListViewController:UISearchBarDelegate {
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//       fetchForSearch(text: searchText)
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchForSearch(text: searchBar.text ?? "")
    }


}
