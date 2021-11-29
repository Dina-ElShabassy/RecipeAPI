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
    
    // Access Shared Defaults Object
    let userDefaults = UserDefaults.standard
    var searchHistoryArray: [String]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchHistoryArray = userDefaults.stringArray(forKey: "SearchHistory") ?? []
        
        dataObj = Data()
        //Removing navigation bar borders
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //show search bar function
        self.showSearchBar()
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        filterCollectionView.allowsSelection = false
        
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
                              
            self.onFailUpdateView()
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
