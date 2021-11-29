//
//  SearchSuggestionExtension.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension SearchSuggestionsTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        //show search history table when user clicks on search
        searchController.searchResultsController?.view.isHidden = false
    }
    
}
