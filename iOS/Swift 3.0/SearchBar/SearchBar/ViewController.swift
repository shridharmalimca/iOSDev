//
//  ViewController.swift
//  SearchBar
//
//  Created by Shridhar Mali on 12/14/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    let arr = ["zxyy", "cde", "bce","abc"]
    var filteredArray = [String]()
    var searchController: UISearchController!
    var shouldShowSearchResult = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter search text"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        tblView.tableHeaderView = searchController.searchBar
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResult {
            return filteredArray.count
        } else {
            return arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if shouldShowSearchResult {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = arr[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
         shouldShowSearchResult = true
         tblView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        // shouldShowSearchResult = false
        // tblView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        shouldShowSearchResult = false
        tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        shouldShowSearchResult = true
        tblView.reloadData()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        
        filteredArray = arr.filter({ (searchText) -> Bool in
            return ((searchText.range(of: searchController.searchBar.text!, options: String.CompareOptions.caseInsensitive) != nil))
        })
        tblView.reloadData()
    }
}


