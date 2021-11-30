//
//  RecipeSearchViewController.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController : UISearchController?
    var recipeSearchViewModel : RecipeSearchViewModel!
    var recipeFilterViewModel : RecipeFilterViewModel!
    var nextPageViewModel : NextPageResultsViewModel!
    var dataObj : Data!
    var resultArray : [Recipe] = [Recipe]()
    var searchKeyword : String?
    let userDefaults = UserDefaults.standard
    var searchHistoryArray: [String]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set search history array from user defaults if doesn't exist and if exists write on it
        searchHistoryArray = userDefaults.stringArray(forKey: "SearchHistory") ?? []
        
        dataObj = Data()
        //Removing navigation bar borders
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //show search bar function
        self.showSearchBar()
        
        //avoid clicking on filter collection view items before search
        filterCollectionView.allowsSelection = false
        
        //delegates
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        recipeSearchViewModel = RecipeSearchViewModel()
        recipeSearchViewModel.bindSearchResultViewModelToView = {
            self.onSearchSuccessUpdateView()
        }
                          
        recipeSearchViewModel.bindViewModelErrorToView = {
                              
            self.onFailUpdateView()
        }
        
        recipeSearchViewModel.bindNoResultToView = {
            self.onEmptyResultUpdateView()
        }
        
        recipeFilterViewModel = RecipeFilterViewModel()
        recipeFilterViewModel.bindFilterResultViewModelToView = {
            self.onFilterSuccessUpdateView()
        }
                          
        recipeFilterViewModel.bindViewModelErrorToView = {
                              
            self.onFilterFailUpdateView()
        }
        
        recipeFilterViewModel.bindNoResultToView = {
            self.onEmptyResultUpdateView()
        }
        
        nextPageViewModel = NextPageResultsViewModel()
        nextPageViewModel.bindNextPageResultViewModelToView = {
            self.onNextPageSuccessUpdateView()
        }
                          
        nextPageViewModel.bindViewModelErrorToView = {
                              
            self.onFailUpdateView()
        }
        
    }

}
