//
//  ViewController.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class AllCatsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(AllCatsTableViewCell.self, forCellReuseIdentifier: String(describing: AllCatsTableViewCell.self))
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllCatsTableViewCell.self), for: indexPath) as! AllCatsTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    


}

