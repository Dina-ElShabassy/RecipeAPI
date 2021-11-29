//
//  SearchSuggestionsTableViewController.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import UIKit

class SearchSuggestionsTableViewController: UITableViewController {
    
    var searchHistoryArray : [String]!
    var searchHistoryDelegate : SearchHistoryProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        searchHistoryArray = UserDefaults.standard.stringArray(forKey: "SearchHistory")?.suffix(10) ?? []
        searchHistoryArray.reverse()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchHistoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchHistoryCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = searchHistoryArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchHistoryDelegate.getSelectedSearchHistoryRecipes(selectedSearchHistory: searchHistoryArray[indexPath.row])
        dismiss(animated: true, completion: nil)
    }

}
