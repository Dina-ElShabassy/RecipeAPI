//
//  RecipeFilterViewModel.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/27/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation

class RecipeFilterViewModel: NSObject {
    
    var networkModel : NetworkModel!
    
    var filterResult : Data! {
        didSet{
            
            self.bindFilterResultViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindFilterResultViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    var bindNoResultToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.networkModel = NetworkModel()
    }
    
    
    func getFilterResult(searchString : String, healthString: String){
        networkModel.fetchFilterResult(searchKeyword: searchString,healthFilter: healthString) { (result, error) in
            
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
            }
            else if result?.hits?.count != 0{
                self.filterResult = result
            }
            else{
                self.bindNoResultToView()
            }
        }
    }
    
}
