//
//  AllCatsTableViewCell.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class AllCatsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AllCatsTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    private let petIconImage: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "m2fZGKx")
        return imageView
    }()
    
    private let containerView:  UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let petNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Pet Name is"
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    func setupSubViews() {
        contentView.addSubview(containerView)
        containerView.addSub(views: [petIconImage,
        petNameLabel,
        likeButton
        ])
        
        petNameLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.frame = CGRect(x: 15, y: 5, width: contentView.frame.width - 30, height: contentView.frame.height - 10)
        petIconImage.frame = CGRect(x: 10, y: 5, width: containerView.frame.height - 10, height: containerView.frame.height - 10)
        
        NSLayoutConstraint.activate([
            petNameLabel.leadingAnchor.constraint(equalTo: petIconImage.trailingAnchor, constant: 12),
            petNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            likeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubViews()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
 
    }

}
