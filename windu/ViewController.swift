//
//  ViewController.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var displayTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var que: NSOperationQueue?
    var netOperation: NetworkOperation?
    var searchActive : Bool = false
    var items: [String] = [] //["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayTableView.delegate = self
        displayTableView.dataSource = self
        searchBar.delegate = self
        que = NSOperationQueue()
        self.displayTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: table view delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = displayTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = items[indexPath.row];
        }
        
        return cell;
    }
    
    // MARK: Search Bar delegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var result: [String] = []
        if count(searchText) > 2 {
            
            if (!que!.operations.isEmpty) {
                netOperation!.cancel()
                //que?.cancelAllOperations()
            }
            
            netOperation = NetworkOperation(router: Router.Search(q: searchText)){
                responseObject , error in
                
                if let obj: SearchSuggestionsModel = responseObject as? SearchSuggestionsModel {
                    for searchSuggestions in obj {
                        for suggestion in searchSuggestions {
                            println(suggestion.localizedName!)
                            
                            result.append(suggestion.localizedName!)
                        }
                    }
                    self.items.removeAll(keepCapacity: false)
                    self.items = result
                }
                
            }
            que?.addOperation(netOperation!)
            
            filtered = items.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.displayTableView.reloadData()
        }
    }
    
}

