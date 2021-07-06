//
//  AllCatsTableViewCell.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class AllCatsTableViewCell: UITableViewCell {
    
    private var imageData: Data?
    
    static let identifier           = String(describing: AllCatsTableViewCell.self)
    var isLiked: Bool               = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: Create TableView Cell Objects
    private let petIconImage: UIImageView   = {
        let imageView                       = UIImageView()
        imageView.layer.cornerRadius        = 12
        imageView.layer.masksToBounds       = true
        imageView.layer.borderWidth         = 0.1
        imageView.image                     = UIImage(named: "currently-unavailable")
        return imageView
    }()
    
    private let containerView: UIView   = {
        let view                        = UIView()
        view.backgroundColor            = .white
        view.clipsToBounds              = true
        return view
    }()
    
    private let petNameLabel: UILabel       = {
        let label                           = UILabel()
        label.minimumScaleFactor            = 0.5
        label.adjustsFontSizeToFitWidth     = true
        return label
    }()
    
    let likeButton: UIButton            = {
        let button                      = UIButton(type: .system)
        return button
    }()
    //MARK: Add Objects to ContentView and Set up Constraints, Frame and View Properties
    func setupSubViews() {
        contentView.addSubview(containerView)
        containerView.addSub(views: [petIconImage, petNameLabel, likeButton ] )
        
        petNameLabel.translatesAutoresizingMaskIntoConstraints  = false
        likeButton.translatesAutoresizingMaskIntoConstraints    = false
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        
        constraints()
        var imageHeight: CGFloat {
            return contentView.frame.height - 10
        }
        containerView.frame         = CGRect(x: 15, y: 5, width: contentView.frame.width - 30,
                                             height: contentView.frame.height - 5)
        petIconImage.frame          = CGRect(x: 10, y: 5, width: imageHeight, height: imageHeight)
        
    }
    
    func plainButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor                = .lightGray
    }
    
    func likedButton() {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.tintColor                = #colorLiteral(red: 0.8705882353, green: 0.007843137255, blue: 0.007843137255, alpha: 1)
    }
    
    func constraints() {
        
        NSLayoutConstraint.activate([
            petNameLabel.leadingAnchor.constraint(equalTo: petIconImage.trailingAnchor, constant: 12),
            petNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            petNameLabel.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 40),
            
            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            likeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            
        ])
        
    }
    //MARK: Configure Cell Items with Data
    func configureCellItems(with model: AllPetsViewModel) {
        model.downloadImage(imageView: petIconImage) { data in
            self.imageData = data
        }
        petNameLabel.text = model.catName
        model.isLiked ? likedButton() : plainButton()
    }
    
    @objc func didTapLikeButton() {
        ///Set up like button function
        isLiked ? unlikeCat() : likeCat()
    }
    
    func unlikeCat(from database: CacheLikedPetViewModel = CacheLikedPetViewModel()) {
        /// Remove an unliked cat from the database
        isLiked = false
        guard let name = petNameLabel.text else { return }
        database.unlikeCachedPet(name: name)
        NotificationCenter.default.post(name: .didUnlikeCat, object: name)
        Constants.Animations.fadeOutLikedButton(button: likeButton)
    }
    
    func likeCat(from database: CacheLikedPetViewModel = CacheLikedPetViewModel()) {
        /// Add a liked cat to the database
        isLiked = true
        guard let petName = petNameLabel.text,
              let data = imageData else { return }
        NotificationCenter.default.post(name: .didLikeCat, object: petName)
        database.saveLikedPet(petName: petName, imageData: data)
        Constants.Animations.animateButtonOnLike(button: likeButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubViews()
        contentView.reloadInputViews()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

