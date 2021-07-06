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
    //MARK: Create Collection View Cell Objects
    let favoriteCatImage: UIImageView    = {
        let image                        = UIImageView()
        image.clipsToBounds              = true
        image.layer.masksToBounds        = true
        image.layer.cornerRadius         = 12
        image.layer.borderWidth          = 0.1
        image.contentMode                = .scaleAspectFill
        return image
    }()
    
    let likeButton: UIButton                = {
        let button                          = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.imageView?.contentMode       = .scaleAspectFit
        button.tintColor = #colorLiteral(red: 0.8705882353, green: 0.007843137255, blue: 0.007843137255, alpha: 1)
        return button
    }()
    
    let nameLabel: UILabel                  = {
        let label                           = UILabel()
        label.font                          = UIFont.systemFont(ofSize: 20)
        label.textColor                     = .black
        label.minimumScaleFactor            = 0.5
        label.adjustsFontSizeToFitWidth     = true
        return label
    }()
    /// Setup collection view cell with the created objects
    func setupViews() {
        contentView.addSub(views: [favoriteCatImage, nameLabel, likeButton])
        favoriteCatImage.frame  = CGRect(x: 0, y: 0, width: contentView.frame.width,
                                        height: contentView.frame.height-35)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints     = false
        likeButton.translatesAutoresizingMaskIntoConstraints    = false
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        constraints()
        
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: favoriteCatImage.bottomAnchor, constant: 5),
            
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeButton.topAnchor.constraint(equalTo: favoriteCatImage.bottomAnchor, constant: 10)
        
        ])
        
    }
    
    @objc func didTapLikeButton () {
        unlikeLikedCat()
    }
    /// Deletes a cat from the database and post a notification after its been unliked
    func unlikeLikedCat(cacheModel: CacheLikedPetViewModel  = CacheLikedPetViewModel()) {
        guard let name                                      = nameLabel.text else { return }
        cacheModel.unlikeCachedPet(name: name)
        contentView.layoutSubviews()
        NotificationCenter.default.post(name: .didUnlikeCat, object: name)
    }
    ///Configure a collection view cell
    func configureCellWith(model: LikedImage) {
        nameLabel.text          = model.petName
        guard let data          = model.imageData else { return }
        favoriteCatImage.image  = UIImage(data: data)
    }
    
    
}
