//
//  AutoCompletePlacesVC.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class AutoCompletePlacesVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var searchController: UISearchController!
    var filteredArray = [Predictions]()                                     //Place pridictions from google places api web service
    let objPlaceDetails = PlaceDetailModel.shardInstance                    // PlaceDetailModel singleton instace
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBarController()                                            // SearchBar in tableview for search places
    }
    
    //MARK:- Private Methods
    func addSearchBarController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        tblView.tableHeaderView = searchController.searchBar
    }
    
    // Get Auto Complete place prediction from google places api web service
    func getAutoCompletePlaces(searchString: String?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let searchText = searchString {
            _ = Server.APIAutoComplete.invokeAPIAutoComplete(searchText: searchText) { (response: APIAutoCompleteResponse) in
                OperationQueue.main.addOperation {
                    switch response {
                    case .error(let error):
                        print("Error is \(error)")
                    case .success(let places):
                        print(places)
                        if let placesArray = places.predictions {
                            self.filteredArray = placesArray
                            self.tblView.reloadData()
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                }
            }
        }
        
    }
    
    // Get the selected place details with placeId
    func getPlacesDetailWith(_ placeId: String?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let placeId = placeId {
            print(placeId)
            _ = Server.APIPlaceDetail.invokeAPIPlaceDetail(placeId: placeId) { (response: APIPlaceDetailResponse) in
                OperationQueue.main.addOperation {
                    switch response {
                    case .error(let error):
                        print(error)
                    case .success(let placesDetail):
                        self.objPlaceDetails.placeDetailsInfo = placesDetail.result
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
}

//MARK:- UISearchBarDelegate
extension AutoCompletePlacesVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tblView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tblView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.dismiss(animated: true, completion: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tblView.reloadData()
    }
}

//MARK:- UISearchResultsUpdating
extension AutoCompletePlacesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        if let searchtext = searchController.searchBar.text, searchController.searchBar.text?.characters.count != 0 {
            getAutoCompletePlaces(searchString: searchtext)
        }
        tblView.reloadData()
    }
}

//MARK:- UITableViewDataSource
extension AutoCompletePlacesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = filteredArray[indexPath.row].description
            cell.detailTextLabel?.text = filteredArray[indexPath.row].structuredFormatting?.secondaryText
        return cell
    }
}

//MARK:- UITableViewDelegate
extension AutoCompletePlacesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = filteredArray[indexPath.row].placeId {
            self.dismiss(animated: true, completion: nil)
            if SRKUtility.isInternetAvailable() {
                getPlacesDetailWith(id)
            } else {
                SRKUtility.showErrorMessage(title: "Internet Status", message: "Please check your internet connectivity", viewController: self)
            }
            
        } else {
            // Show alert msg with proper text
            SRKUtility.showErrorMessage(title: "Error", message: "Please select place again", viewController: self)
        }
    }
}


