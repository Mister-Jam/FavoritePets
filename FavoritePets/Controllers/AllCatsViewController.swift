//
//  ViewController.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class AllCatsViewController: UITableViewController {
    private var spinner                                              = SpinnerViewController()
    private var fetchedPetsModelData                                 = [AllPetsViewModel]()
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                                         = .white
        setupTableView()
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        fetchCatsData()
        listenForUnlikedCats()
        listenForLikedCats()
    }
    
    //MARK: Set up TableView Properties and Register Table Cell
    private func setupTableView() {
        tableView.register(AllCatsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: AllCatsTableViewCell.self))
        tableView.separatorStyle                                      = .none
    }
    
    //MARK: Call Network Manager class and Load Cats Data from API
    private func fetchCatsData() {

        spinner.start(container: Constants.topMostController())
        NetworkManager.shared.getCatsData { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                /// Pass Returned Data to View Model Class
                strongSelf.fetchedPetsModelData = data.compactMap({ pets in
                    AllPetsViewModel(name: pets.name, imageUrl: pets.image?.url ?? "No url", likeStatus: false)
                })
                /// Filter the data to reflect liked pets and Reload Table
                DispatchQueue.main.async {
                    strongSelf.filterDataForLikedPets()
                    strongSelf.tableView.reloadData()
                    strongSelf.spinner.stop()
                }
            case .failure(let error):
                ///Display Error Alert if unable to load data from API
                DispatchQueue.main.async {
                    strongSelf.spinner.stop()
                    Constants.failureAlert(viewController: strongSelf,
                                           text: "\(Constants.Alert.fetchErrorText)\n\(String(describing: error.localizedDescription))")
                }
            }
        }
    }
    
    
    //MARK: Listen for posted notifications of pets liked and unliked
    private func listenForLikedCats() {
        /// Observe for when a pet is liked and update the model accordingly
        observer            = NotificationCenter.default.addObserver(
                                                forName: .didLikeCat, object: nil, queue: .main, using: { [weak self] cat in
            guard let name          = cat.object as? String,
                  let strongSelf    = self else { return }
            for (index, cat) in strongSelf.fetchedPetsModelData.enumerated() {
                if cat.catName      == name {
                    strongSelf.fetchedPetsModelData[index].isLiked = true
                    strongSelf.tableView.reloadData()
                }
            }
        })
    }
    
    private func listenForUnlikedCats() {
        /// Observe for when a pet is unliked, and update the model accordingly
        observer            = NotificationCenter.default.addObserver(
                                                forName: .didUnlikeCat, object: nil, queue: .current, using: { [weak self] item in
    
            guard let name          = item.object as? String else { return }
            guard let strongSelf    = self else { return }
            for (index, cat) in strongSelf.fetchedPetsModelData.enumerated() {
                if cat.catName      == name {
                    strongSelf.fetchedPetsModelData[index].isLiked = false
                    strongSelf.tableView.reloadData()
                }
            }
            
        })
    }
    
    //MARK: Compare incoming data with cached data and update the model so the UI reflects liked pets
    private func filterDataForLikedPets(model: CacheLikedPetViewModel = CacheLikedPetViewModel()) {
        model.getLikedPets()
        let likedPetsNames = model.cachedPetsModel.compactMap { pet in
            pet.petName
        }
        var count   = likedPetsNames.count
        var i       = 0
        
        while count > 0 {
            let index = fetchedPetsModelData.firstIndex { pet in
                pet.catName == likedPetsNames[i]
            }
            if let index = index {
                fetchedPetsModelData[index].isLiked = true
            }
            
            count   -= 1
            i       += 1
        }
    }
    /// Remove observers when the class is deinitialized
    deinit {
        if let oberver = observer {
            print("successfully deinitializeded")
            NotificationCenter.default.removeObserver(oberver)
        }
    }
    
    //MARK: Table view Delegate and Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedPetsModelData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllCatsTableViewCell.self),
                                                 for: indexPath) as! AllCatsTableViewCell
        cell.configureCellItems(with: fetchedPetsModelData[indexPath.row])
        cell.layoutSubviews()
        tableView.reloadInputViews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

