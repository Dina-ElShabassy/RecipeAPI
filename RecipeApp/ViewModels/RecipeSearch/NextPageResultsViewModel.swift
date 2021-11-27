//
//  NextPageResultsViewModel.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/27/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation

class NextPageResultsViewModel: NSObject{
    var networkModel : NetworkModel!
    
    var nextPageResult : Data! {
        didSet{
            
            self.bindNextPageResultViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindNextPageResultViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    override init() {
        
        super .init()
        self.networkModel = NetworkModel()
    }
    
    
    func getNextPageResults(nextPageURL : String){
        networkModel.fetchNextPageData(nextPageLink: nextPageURL){ (result, error) in
            
            if let error : Error = error{
            
                let message = error.localizedDescription
                self.showError = message
            }
            else{
                self.nextPageResult = result
            }
            
        }
    }
    
}
