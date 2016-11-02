//
//  TestSearchbarFocus.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 31/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//
//  Reference: https://www.raywenderlich.com/113772/uisearchcontroller-tutorial
//

import UIKit


class TestSearchbarFocus: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    
    let data = ["ABC", "BBC", "CCD", "Enix", "Peter", "Earth"]
    var displayData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        searchController.active = true
        searchController.searchBar.becomeFirstResponder()
    }
    
    func filterDataForSearchText(text: String){
        displayData = data.filter({
            (item) -> Bool in
            item.lowercaseString.containsString(text.lowercaseString)
        })
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterDataForSearchText(searchController.searchBar.text!)
    }
    
    // MARK : UITableViewDataSource/Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return displayData.count
        }
        
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if searchController.active && searchController.searchBar.text != "" {
            cell.textLabel?.text = displayData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }
}