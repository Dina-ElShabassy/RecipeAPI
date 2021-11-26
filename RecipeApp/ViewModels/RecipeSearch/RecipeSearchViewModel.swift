//
//  RecipeSearchViewModel.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/25/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation

class RecipeSearchViewModel: NSObject{
    var networkModel : NetworkModel!
    
    var searchResult :[Recipe]! {
        didSet{
            
            self.bindSearchResultViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindSearchResultViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    var bindNoResultToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.networkModel = NetworkModel()
    }
    
    
    func getSearchResult(searchString : String){
        networkModel.fetchSearchResult(searchKeyword: searchString) { (result, error) in
            
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
            }
            else if result?.count != 0{
                self.searchResult = result
            }
            else{
                self.bindNoResultToView()
            }
        }
    }
    
}
