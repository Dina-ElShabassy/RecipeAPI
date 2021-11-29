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
        return resultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeSearchCell", for: indexPath) as? TableViewCell
        
        cell?.recipeImage.sd_setImage(with: URL(string: resultArray[indexPath.row].recipe!.image!))
        cell?.recipeTitle.text = resultArray[indexPath.row].recipe?.label
        cell?.recipeSource.text = resultArray[indexPath.row].recipe?.source
        var healthLabels = ""
        for label in resultArray[indexPath.row].recipe!.healthLabels!{
            healthLabels.append("\(label),")
        }
        cell?.recipeHealthLabels.text = healthLabels
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
      
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            //i am at the bottom of the table view
            if let nextObj = dataObj._links?.next {
                //scroll to top and get the data of next page
                scrollToTop()
                let nextPageLink = nextObj.href
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                nextPageViewModel.getNextPageResults(nextPageURL: nextPageLink!)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetails") as! RecipeDetailsViewController
        
        recipeDetailsVC.recipeDetailsObj = resultArray[indexPath.row].recipe
        
        self.navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }

}
