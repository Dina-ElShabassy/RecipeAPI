//
//  CollectionViewCell.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var filterLabel: UILabel!
    
    override func layoutSubviews() {
           // cell rounded section
           self.layer.cornerRadius = 15.0
           self.layer.borderWidth = 5.0
           self.layer.borderColor = UIColor.clear.cgColor
           self.layer.masksToBounds = true
           
           // cell shadow section
           self.contentView.layer.cornerRadius = 15.0
           self.contentView.layer.borderWidth = 5.0
           self.contentView.layer.borderColor = UIColor.clear.cgColor
           self.contentView.layer.masksToBounds = true
           self.layer.shadowColor = UIColor.white.cgColor
           self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
           self.layer.shadowRadius = 6.0
           self.layer.shadowOpacity = 0.6
           self.layer.cornerRadius = 15.0
           self.layer.masksToBounds = false
           self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
       }
    
}
