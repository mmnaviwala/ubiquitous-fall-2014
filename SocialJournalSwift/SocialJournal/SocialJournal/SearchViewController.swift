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
    var searchResults: [PFObject] = []
    var allObjects: [PFObject] = []
    var currentTableViewArray = []
    var entryToPassWhenRowSelected = PFObject(className: "Entry")
    var userToPassWhenRowSelected = PFObject(className: "User")

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheHamburgerIcon()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllUsers()
        fetchAllEntries()
        
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
        var query = ParseQueries.queryForAllEntries()
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
        
        var userCell = self.tableView.dequeueReusableCellWithIdentifier("searchUserCell") as SearchUserCell
        var postCell = self.tableView.dequeueReusableCellWithIdentifier("searchPostCell") as SearchPostCell
        
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            currentTableViewArray = searchResults
        } else {
            currentTableViewArray = allObjects
        }
        
        if (currentTableViewArray[indexPath.row].isKindOfClass(PFUser)){
            var user = currentTableViewArray[indexPath.row] as PFUser
            userCell.userName.text = user.username
            
            return userCell
        }else{
            var object = currentTableViewArray[indexPath.row] as PFObject
            
            postCell.postTitle.text = object["title"] as String!
            
            var contentString = object["content"] as String!
            var contentLength = (countElements(contentString) > 200) ? 200 : countElements(contentString)
            // limiting the post content on the cells to 200 at most
            
            let substringRange = Range(start: contentString.startIndex, end: advance(contentString.startIndex, contentLength))
            postCell.postContent.text = contentString.substringWithRange(substringRange)
            
            var postUser = (object["user"]).fetchIfNeeded() as PFUser
            postCell.userName.text = postUser.username
            
            return postCell
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.currentTableViewArray[indexPath.row].isKindOfClass(PFUser)){
            self.userToPassWhenRowSelected = self.currentTableViewArray[indexPath.row] as PFObject
            self.performSegueWithIdentifier("fromSearchToProfile", sender: self)
        }else{
            self.entryToPassWhenRowSelected = self.currentTableViewArray[indexPath.row] as PFObject
            self.performSegueWithIdentifier("fromSearchToEntryView", sender: self)
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.searchResults = self.allObjects.filter({( object: PFObject) -> Bool in
            
            var userStringMatch = false
            var postStringMatch = false
            if(object.isKindOfClass(PFUser)){
                var user = object as PFUser
                if user.username.lowercaseString.rangeOfString(searchText) != nil{
                    userStringMatch = true
                }
            }else {
                var title:String = object["title"] as String
                if title.lowercaseString.rangeOfString(searchText) != nil{
                    postStringMatch = true
                }
            }
            return (userStringMatch || postStringMatch)
            
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "fromSearchToEntryView"{
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.entryToPassWhenRowSelected
        }
        
        if (segue.identifier == "fromSearchToProfile"){
            let vc = segue.destinationViewController as ProfileViewController
            vc.currentUser = self.userToPassWhenRowSelected as PFUser
        }
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
