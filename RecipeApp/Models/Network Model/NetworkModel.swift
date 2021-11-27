//
//  NetworkModel.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/25/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkModel {
    
    func fetchSearchResult(searchKeyword: String,completion : @escaping (Data?, Error?)->()){
        
        let params: [String: Any] = [
            "q": searchKeyword,
            "app_id": Constants.app_id,
            "app_key": Constants.app_key
        ]
        
        AF.request(Constants.searchURL, parameters : params)
            .validate()
            .responseDecodable(of: Data.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let searchResult = response.value else { return }
                    //var obj = Data()
                    //obj.links?.next?.href = searchResult.links?.next?.href
                    //obj.hits = searchResult.hits
                    
                    completion(searchResult,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
        
    }
    
    func fetchFilterResult(searchKeyword: String,healthFilter: String,completion : @escaping (Data?, Error?)->()){
        
        let params: [String: Any] = [
            "q": searchKeyword,
            "app_id": Constants.app_id,
            "app_key": Constants.app_key,
            "health": healthFilter
        ]
        
        AF.request(Constants.searchURL, parameters : params)
            .validate()
            .responseDecodable(of: Data.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let filterResult = response.value else { return }
                    
                    completion(filterResult,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
        
    }
    
    func fetchNextPageData(nextPageLink: String, completion : @escaping (Data?, Error?)->()){
    
        AF.request(nextPageLink)
            .validate()
            .responseDecodable(of: Data.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let result = response.value else { return }
                    
                    completion(result,nil)
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}
