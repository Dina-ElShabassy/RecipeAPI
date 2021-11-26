//
//  RecipeSearch+TableView.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension RecipeSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeSearchCell", for: indexPath) as? TableViewCell
        
        cell?.recipeImage.sd_setImage(with: URL(string: searchResultArray[indexPath.row].recipe!.image!))
        cell?.recipeTitle.text = searchResultArray[indexPath.row].recipe?.label
        cell?.recipeSource.text = searchResultArray[indexPath.row].recipe?.source
        var healthLabels = ""
        for label in searchResultArray[indexPath.row].recipe!.healthLabels!{
            healthLabels.append("\(label),")
        }
        cell?.recipeHealthLabels.text = healthLabels
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
      
    }


}
