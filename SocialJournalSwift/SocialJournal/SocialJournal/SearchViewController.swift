//
//  SearchViewController.swift
//  SocialJournal
//
//  Created by Gabe on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    var button: HamburgerButton! = nil
    // var userNames = ["@cleanCodeMafia", "@theBigDawg", "@teslaRocks"]
    var searchResults: [PFObject] = []
    var allObjects: [PFObject] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheHamburgerIcon()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllUsers()
        fetchAllEntries()
//        self.searchDisplayController?.searchBar.scopeButtonTitles = ["users", "posts"]
        
    }
    
    func fetchAllUsers() {
        var query = ParseQueries.queryForAllUsers(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.allObjects.append(object.fetchIfNeeded() as PFUser)
                }
                println("Users fetched")
                self.tableView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func fetchAllEntries() {
        var query = ParseQueries.queryForEntries(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.allObjects.append(object.fetchIfNeeded())
                }
                println("Entries fetched")
                self.tableView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
        }
    }
    
    func setupTheHamburgerIcon() {
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            return searchResults.count
        }else {
            return allObjects.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var arrayForTableView = []
        if (tableView == self.searchDisplayController!.searchResultsTableView){
            arrayForTableView = searchResults
        }else {
            arrayForTableView = allObjects
        }
        
        if (allObjects[indexPath.row].isKindOfClass(PFUser)){
            var cell = self.tableView.dequeueReusableCellWithIdentifier("searchUserCell", forIndexPath: indexPath) as SearchUserCell
            
            var user = allObjects[indexPath.row] as PFUser
            cell.userName.text = user.username
            
            return cell
        }else{
            var cell = self.tableView.dequeueReusableCellWithIdentifier("searchPostCell", forIndexPath: indexPath) as SearchPostCell
            
            var object = allObjects[indexPath.row]
            cell.postTitle.text = object["title"] as String!
            
            return cell
        }
        
        
        
        /*
        var cell = self.tableView.dequeueReusableCellWithIdentifier("searchUserCell", forIndexPath: indexPath) as SearchUserCell
        
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            var user = searchResults[indexPath.row] as PFUser
            cell.userName.text = user.username
        } else {
            var user = allObjects[indexPath.row] as PFUser
            cell.userName.text = user.username
        }
        return cell
        */
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.searchResults = self.allObjects.filter({( object: PFObject) -> Bool in
//            let stringMatch = user.username.rangeOfString(searchText)
//            return (stringMatch != nil)
            var user = object as PFUser
            if ((user.username) != nil){
                let stringMatch = user.username.rangeOfString(searchText)
                return (stringMatch != nil)
            }else{
                return false
            }
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
