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
    let cellIdentifier = "cell"
    var que: NSOperationQueue?
    var netOperation: NetworkOperation?
    var searchActive : Bool = false
    var types: [String] = []
    var suggestionsList: Array<SuggestionsModel>  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayTableView.delegate = self
        displayTableView.dataSource = self
        searchBar.delegate = self
        que = NSOperationQueue.mainQueue()
        self.displayTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: table view delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if suggestionsList.count > 0 {
            return self.suggestionsList.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case GroupType.Cities.index:
            return suggestionsList[section].suggestions!.count
        case GroupType.Regions.index:
            return suggestionsList[section].suggestions!.count
        case GroupType.Districts.index:
            return suggestionsList[section].suggestions!.count
        default: return 0
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case  GroupType.Cities.index:
            return GroupType.Cities.rawValue
        case GroupType.Regions.index:
            return GroupType.Regions.rawValue
        case GroupType.Districts.index:
            return GroupType.Districts.rawValue
        default: return "nothing to display"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = displayTableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as! UITableViewCell
        let section = indexPath.section
        let row = indexPath.row
        
        if(self.searchActive) {
            switch (section) {
            case GroupType.Cities.index:
                cell.textLabel?.text = suggestionsList[section].suggestions![row].localizedName!
            case GroupType.Regions.index:
                cell.textLabel?.text = suggestionsList[section].suggestions![row].localizedName!
            case GroupType.Districts.index:
                cell.textLabel?.text = suggestionsList[section].suggestions![row].localizedName!
            default: break
            }
            
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
        
        self.suggestionsList.removeAll(keepCapacity: false)
        if count(searchText) > 2 {
            
            if (!que!.operations.isEmpty) {
                netOperation!.cancel()
                //que?.cancelAllOperations()
            }
            
            netOperation = NetworkOperation(router: Router.Search(q: searchText)) {
                responseObject , error in
                if let obj: SearchSuggestionsModel = responseObject as? SearchSuggestionsModel {
                    for searchSuggestions in obj {
                        searchSuggestions.suggestions = searchSuggestions.suggestions!.filter({ (sug: SuggestionModel) in
                            let tmp: NSString = sug.localizedName!
                            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                            return range.location != NSNotFound
                        })
                        self.suggestionsList.append(searchSuggestions)
                    }
                    
                }
                
                if(self.suggestionsList.count == 0) {
                    self.searchActive = false;
                } else {
                    self.searchActive = true;
                }
                self.displayTableView.reloadData()
                
            }
            netOperation?.qualityOfService = NSQualityOfService.Background
            netOperation?.queuePriority = NSOperationQueuePriority.High
            que?.addOperation(netOperation!)
            
        }
    }
    
}

