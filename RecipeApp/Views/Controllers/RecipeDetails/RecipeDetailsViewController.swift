//
//  RecipeDetailsViewController.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/28/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientsListTableView: UITableView!
    
    var ingredientListArray : [String] = [String]()
    var recipeDetailsObj : RecipeDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share(sender:)))
        
        ingredientsListTableView.delegate = self
        ingredientsListTableView.dataSource = self
        
        recipeImage.sd_setImage(with: URL(string: recipeDetailsObj.image!))
        recipeTitle.text = recipeDetailsObj.label!
        ingredientListArray = recipeDetailsObj.ingredientLines!
        
    }
    
    @IBAction func recipeWebsiteButton(_ sender: Any) {
        
        if let url = URL(string: recipeDetailsObj.url!) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
        
    }
    
    @objc func share(sender:UIView){

        if let recipeWebsite = URL(string: recipeDetailsObj.url!) {
            let activityVC = UIActivityViewController(activityItems: [recipeWebsite], applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
        
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
