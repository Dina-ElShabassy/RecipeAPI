//
//  RecipeSearch+CollectionView.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension RecipeSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.filterLabel.text = Constants.filterLabelsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var healthFilter : String?
        
        switch indexPath.row {
        case 0:
            recipeSearchViewModel.getSearchResult(searchString: searchController!.searchBar.text!)
        case 1:
            healthFilter = "low-sugar"
            recipeFilterViewModel.getFilterResult(searchString: searchController!.searchBar.text!, healthString: healthFilter!)
        case 2:
            healthFilter = "keto-friendly"
            recipeFilterViewModel.getFilterResult(searchString: searchController!.searchBar.text!, healthString: healthFilter!)
        case 3:
            healthFilter = "vegan"
            recipeFilterViewModel.getFilterResult(searchString: searchController!.searchBar.text!, healthString: healthFilter!)
        default:
            print("index out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 132, height: collectionView.bounds.height)
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
