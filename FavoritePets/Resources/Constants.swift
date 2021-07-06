//
//  Constants.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

struct Constants {
    static let titleText            = [NSAttributedString.Key.foregroundColor: UIColor.black,
                            .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    static let tabBarText           = [NSAttributedString.Key.foregroundColor: UIColor.black,
                             .font: UIFont.systemFont(ofSize: 13, weight: .regular)]
    static let noLikedPetsLabel     = "You have not liked any cats yet\nLike a cat and they will appear on this screen"
    
    struct UrlConstants {
        static let baseUrl          = "https://api.thecatapi.com/"
    }
    
    struct Alert {
        static let alreadyLikedTitle = "This is Awkward"
        static let alreadyLikedText  = "This cat have already been liked\nThe view will update now"
        static let fetchErrorText    = "There was an error loading the cats data"
        
    }
    
    struct Animations {
        static func animateButtonOnLike (button: UIButton) {
            button.alpha                        = 0
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 10, options: [], animations: {
                            button.transform    = CGAffineTransform(translationX: 2, y: -5)
                            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                            button.alpha        = 1
                            button.tintColor    = #colorLiteral(red: 0.8705882353, green: 0.007843137255, blue: 0.007843137255, alpha: 1)
            }) { _ in
                button.transform = .identity
            }
        }
        
        static func fadeOutLikedButton(button: UIButton) {
            button.alpha                        = 0.2
            button.translatesAutoresizingMaskIntoConstraints = false
            UIView.animate(withDuration: 0.7, animations: {
                button.setImage(UIImage(systemName: "heart"), for: .normal)
                button.alpha                    = 1
                button.tintColor                = .lightGray
            })
        }
    }
    
    static func failureAlert(title: String = "Woops!", viewController: UIViewController, text: String,
                             completion: ((UIAlertAction) -> Void)? = nil) {

        let controller      = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alert           = UIAlertAction(title: "Dismiss", style: .cancel, handler: completion)
        controller.addAction(alert)
        viewController.present(controller, animated: true, completion: nil)

    }
}
