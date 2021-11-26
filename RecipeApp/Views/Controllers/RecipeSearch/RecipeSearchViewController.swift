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
    var searchController : UISearchController? = nil
    var recipeSearchViewModel : RecipeSearchViewModel!
    var searchResultArray : [Recipe] = [Recipe]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        recipeSearchViewModel = RecipeSearchViewModel()
        recipeSearchViewModel.bindSearchResultViewModelToView = {
            self.onSuccessUpdateView()
        }
                          
        recipeSearchViewModel.bindViewModelErrorToView = {
                              
           //onFailUpdateView()
        }
        
        recipeSearchViewModel.bindNoResultToView = {
            self.onEmptyResultUpdateView()
        }
        
        //Removing navigation bar borders
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //show search bar function
        self.showSearchBar()
        
        searchController?.searchBar.delegate = self
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func onSuccessUpdateView(){
        //hideLoading(activityIndicator: activityIndicator)
        noResultsLabel.isHidden = true
        searchResultTableView.isHidden = false
        searchResultArray = recipeSearchViewModel.searchResult
        searchResultTableView.reloadData()
        
    }
    
    func onEmptyResultUpdateView(){
       searchResultTableView.isHidden = true
        noResultsLabel.isHidden = false
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}