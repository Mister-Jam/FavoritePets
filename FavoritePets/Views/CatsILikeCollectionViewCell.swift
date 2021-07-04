//
//  CatsILikeCollectionViewCell.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class CatsILikeCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.image = UIImage(named: "m2fZGKx")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = #colorLiteral(red: 0.8705882353, green: 0.007843137255, blue: 0.007843137255, alpha: 1)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.text = "the name of the per"
        return label
    }()
    
    func setupViews() {
        contentView.addSub(views: [profileImage, nameLabel, likeButton])
        profileImage.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height-35)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10)
        
        ])
        
    }
}
