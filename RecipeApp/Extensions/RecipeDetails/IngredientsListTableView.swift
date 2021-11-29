//
//  IngredientsListTableView.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/28/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel!.text = ingredientListArray[indexPath.row]
        
        return cell
    }
    
    
}

extension RecipeDetailsViewController{
    
    @objc func share(sender:UIView){

        if let recipeWebsite = URL(string: recipeDetailsObj.url!) {
            let activityVC = UIActivityViewController(activityItems: [recipeTitle!,recipeWebsite], applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
}
