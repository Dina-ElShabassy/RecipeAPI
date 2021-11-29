//
//  RecipeSearchExtention.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension RecipeSearchViewController: UISearchBarDelegate, SearchHistoryProtocol{
    
    //add search bar to the view
        func showSearchBar()  {
            //search
            let searchSuggestionsVC = storyboard!.instantiateViewController(withIdentifier: "SearchSuggestions") as! SearchSuggestionsTableViewController
            //to display search results in location search table view
            searchController = UISearchController(searchResultsController: searchSuggestionsVC)
            searchController?.searchResultsUpdater = searchSuggestionsVC
            
            searchSuggestionsVC.searchHistoryDelegate = self

            //configures the search bar, and embeds it within the navigation bar
            let searchBar = searchController?.searchBar
    //        searchBar?.sizeToFit()
            searchBar?.placeholder = "Search for recipe name or food ingredient"
            searchController?.hidesNavigationBarDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
            
            navigationItem.titleView = searchBar
            //navigationItem.searchController = searchController
            searchController?.searchBar.delegate = self
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
            searchKeyword = searchBar.text!
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            recipeSearchViewModel.getSearchResult(searchString: searchKeyword!)
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
    
    func getSelectedSearchHistoryRecipes(selectedSearchHistory: String) {
        
        let selectedIndex = searchHistoryArray!.firstIndex(of: selectedSearchHistory)
        searchHistoryArray?.remove(at: selectedIndex!)
        searchKeyword = selectedSearchHistory
        searchController!.searchBar.text = searchKeyword
        recipeSearchViewModel.getSearchResult(searchString: searchKeyword!)
    }
    
    func onSearchSuccessUpdateView(){
        filterCollectionView.allowsSelection = true
        if searchHistoryArray.contains(searchKeyword!){
            let selectedIndex = searchHistoryArray!.firstIndex(of: searchKeyword!)
            searchHistoryArray?.remove(at: selectedIndex!)
        }
        searchHistoryArray.append(searchKeyword!)
        userDefaults.set(searchHistoryArray, forKey: "SearchHistory")
        activityIndicator.stopAnimating()
        noResultsLabel.isHidden = true
        searchResultTableView.isHidden = false
        resultArray.removeAll()
        dataObj = recipeSearchViewModel.searchResult
        resultArray = dataObj.hits!
        searchResultTableView.reloadData()
        
    }
    
    func onFilterSuccessUpdateView(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        noResultsLabel.isHidden = true
        searchResultTableView.isHidden = false
        resultArray.removeAll()
        dataObj = recipeFilterViewModel.filterResult
        resultArray = dataObj.hits!
        searchResultTableView.reloadData()
    }
    
    func onEmptyResultUpdateView(){
       activityIndicator.isHidden = true
       activityIndicator.stopAnimating()
       searchResultTableView.isHidden = true
       noResultsLabel.isHidden = false
        
    }
    
    func onNextPageSuccessUpdateView(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        noResultsLabel.isHidden = true
        searchResultTableView.isHidden = false
        resultArray.removeAll()
        dataObj = nextPageViewModel.nextPageResult
        resultArray = dataObj.hits!
        searchResultTableView.reloadData()
    }
    
    func onFailUpdateView(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        Alert().showAlert(title: "Error", message: recipeSearchViewModel.showError, vc: self)
    }
    
    func scrollToTop() {
        
        let topRow = IndexPath(row: 0,section: 0)
     
        self.searchResultTableView.scrollToRow(at: topRow, at: .top, animated: false)
    }
    
}

    

