//
//  Extensions.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

extension UIView {
    
    func addSub(views: [UIView] ) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
