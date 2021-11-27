//
//  RecipeSearchExtention.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension RecipeSearchViewController: UISearchBarDelegate{
    
    //add search bar to the view
        func showSearchBar()  {
            //search
            let searchSuggestionsVC = storyboard!.instantiateViewController(withIdentifier: "SearchSuggestions") as! SearchSuggestionsTableViewController
            //to display search results in location search table view
            searchController = UISearchController(searchResultsController: searchSuggestionsVC)
            searchController?.searchResultsUpdater = searchSuggestionsVC

            //configures the search bar, and embeds it within the navigation bar
            let searchBar = searchController?.searchBar
    //        searchBar?.sizeToFit()
            searchBar?.placeholder = "Search for recipe name or food ingredient"
            searchController?.hidesNavigationBarDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
            
            navigationItem.titleView = searchBar
            
            //searchController?.obscuresBackgroundDuringPresentation = true
            definesPresentationContext = true
            
            //change cancel button color
            UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.black
        }
    
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard addRestrictionsToSearchBar(searchKeyword: searchBar.text!) != false
            else{
                searchBar.text = ""
                filterCollectionView.allowsSelection = false
                return
        }
        if (searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces))?.isEmpty == true{
            //alert
            Alert().showAlert(title: "Invalid input", message: "Empty spaces only are not allowed", vc: self)
            searchBar.text = ""
            filterCollectionView.allowsSelection = false
                    }
        else
        {
            recipeSearchViewModel.getSearchResult(searchString: searchBar.text!)
            filterCollectionView.allowsSelection = true
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultTableView.isHidden = true
        noResultsLabel.isHidden = false
        filterCollectionView.allowsSelection = false
    }
    
    func addRestrictionsToSearchBar(searchKeyword : String) -> Bool
    {
         
                do {
                    let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                    if regex.firstMatch(in: searchKeyword , options: [], range: NSMakeRange(0, searchKeyword.count)) != nil {
                         //alert
                        Alert().showAlert(title: "Invalid input", message: "Only english letters & spaces are allowed ", vc: self)
                        return false
                                   }
                               }
                               catch {
                                   print("ERROR")
                               }
                        return true
                }
    }

    

