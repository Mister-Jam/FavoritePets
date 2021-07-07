//
//  CatsILikeViewController.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class CatsILikeViewController: UICollectionViewController {
    ///Initialize View Model Class and observer
    private var cachedPets                  = CacheLikedPetViewModel()
    private var likedPetsObserver: NSObjectProtocol?
    ///Sort the array of cached images in ascending order
    var sortedLikedPets: [LikedImage] {
        return cachedPets.cachedPetsModel.sorted { item0, item1 in
            guard let item0Name = item0.petName, let item1Name = item1.petName else {
                return false
            }
            return item0Name < item1Name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Gets a Notification when a cat has been unliked and reloads the data and view
        likedPetsObserver  = NotificationCenter.default.addObserver(
                                            forName: .didUnlikeCat, object: nil, queue: .main, using: { [self] item in
            cachedPets.getLikedPets(collection: collectionView)
            collectionView.reloadInputViews()
        })
        navigationController?.navigationBar.largeTitleTextAttributes    = Constants.titleText
        cachedPets.getLikedPets(collection: collectionView)
        view.backgroundColor                                            = .lightGray
        collectionView.backgroundColor                                  = .white
        
        collectionView.register(CatsILikeCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: CatsILikeCollectionViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackground()
    }
    ///Remove notification observer after view has been deinitialized
    deinit {
        if let observer         = likedPetsObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private let noLikedCatsLabel: UILabel = {
       let label                = UILabel()
        label.numberOfLines     = 0
        label.isHidden          = true
        label.textAlignment     = .center
        label.text              = Constants.noLikedPetsLabel
        label.font              = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    ///Setup collection view to hide and display label when model is empty
    private func setupBackground() {
        view.addSubview(noLikedCatsLabel)
        if sortedLikedPets.isEmpty {
            collectionView.isHidden     = true
            noLikedCatsLabel.isHidden   = false
            noLikedCatsLabel.frame      = CGRect(x: 10, y: 10, width: view.frame.width - 20,
                                            height: view.frame.height - 20)
            noLikedCatsLabel.center     = view.center
        } else {
            noLikedCatsLabel.isHidden   = true
            collectionView.isHidden     = false
            cachedPets.getLikedPets(collection: collectionView)
        }
    }
    //MARK: Set up collection view layout
    static func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize            = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item                = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets      = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 7)
        let groupSize           = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/3.5))
        let group               = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.contentInsets     = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section             = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    //MARK: Collection View Delegate and Datasource Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedLikedPets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CatsILikeCollectionViewCell.self),
                                                      for: indexPath) as! CatsILikeCollectionViewCell
        cell.configureCellWith(model: sortedLikedPets[indexPath.row])
        return cell
    }
}


