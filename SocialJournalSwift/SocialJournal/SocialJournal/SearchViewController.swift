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
    
    var allUsers: [PFObject] = []
    var allEntries: [PFObject] = []
    var allTags: [PFObject] = []
    var searchResultsForUsers: [PFObject] = []
    var searchResultsForEntries: [PFObject] = []
    var searchResultsForTags: [PFObject] = []
    var selectedTag = ""
    var currentTableViewArray = []
    var objectToPass:PFObject? = nil
 
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheHamburgerIcon()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllUsers()
        fetchAllEntries()
        fetchAllTags()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        messageLabel.hidden = false
        searchDisplayController?.searchResultsTableView.backgroundColor = UIColor.clearColor()
        
    }
    
    func fetchAllUsers() {
        var query = ParseQueries.queryForAllUsers(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.allUsers.append(object as PFUser)
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
                    self.allEntries.append(object as PFObject)
                }
                println("Entries fetched")
                self.tableView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
        }
    }
    
    func fetchAllTags() {
        var query = ParseQueries.queryForAllTags()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.allTags.append(object as PFObject)
                }
                println("Tags fetched")
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            messageLabel.hidden = true
            return 3
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "USERS"
        } else if (section == 1){
            return "TAGS"
        } else if (section == 2){
            return "ENTRIES"
        } else{
            return ""
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        header.textLabel.frame = header.frame
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            if (section == 0) {
                return searchResultsForUsers.count
            }else if (section == 1){
                return searchResultsForTags.count
            }else{
                return searchResultsForEntries.count
            }
        } else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var userCell = self.tableView.dequeueReusableCellWithIdentifier("searchUserCell") as SearchUserCell
        var tagCell = self.tableView.dequeueReusableCellWithIdentifier("searchTagCell") as SearchTagCell
        var postCell = self.tableView.dequeueReusableCellWithIdentifier("searchPostCell") as SearchPostCell
        
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            if (indexPath.section == 0){
                currentTableViewArray = searchResultsForUsers
            }else if (indexPath.section == 1){
                currentTableViewArray = searchResultsForTags
            }else{
                currentTableViewArray = searchResultsForEntries
            }
        } else {
            if (indexPath.section == 0){
                currentTableViewArray = allUsers
            }else if (indexPath.section == 1){
                currentTableViewArray = allTags
            }else{
                currentTableViewArray = allEntries
            }
        }
        
        if (indexPath.section == 0){
            var user = currentTableViewArray[indexPath.row] as PFUser
            userCell.userName.text = user.username
            
            return userCell
        }else if (indexPath.section == 1){
            var object = currentTableViewArray[indexPath.row] as PFObject
            tagCell.tagLabel.text = object["tag"] as String!
            return tagCell
        }else{
            var object = currentTableViewArray[indexPath.row] as PFObject
            
            postCell.postTitle.text = object["title"] as String!
            
            var contentString = object["content"] as String!
            var contentLength = (countElements(contentString) > 200) ? 200 : countElements(contentString)
            // limiting the post content on the cells to 200 at most
            
            let substringRange = Range(start: contentString.startIndex, end: advance(contentString.startIndex, contentLength))
            postCell.postContent.text = contentString.substringWithRange(substringRange)

            // Async call to fetch user info
            object["user"].fetchIfNeededInBackgroundWithBlock {
                (object: PFObject!, error: NSError!) -> Void in
                if error == nil {
                    postCell.userName.text = object["username"] as String!
                } else {
                    NSLog("Error: %@ %@", error, error.userInfo!)
                }
                
            }
            return postCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            if (indexPath.section == 0) {
                self.objectToPass = searchResultsForUsers[indexPath.row]
            }else if(indexPath.section == 1){
                var object = searchResultsForTags[indexPath.row] as PFObject
                self.selectedTag = object["tag"] as String!
            }else{
                self.objectToPass = searchResultsForEntries[indexPath.row]
            }
        }else {
            if (indexPath.section == 0) {
                self.objectToPass = allUsers[indexPath.row]
            }else if(indexPath.section == 1){
                var object = searchResultsForTags[indexPath.row] as PFObject
                self.selectedTag = object["tag"] as String!
            }else{
                self.objectToPass = allEntries[indexPath.row]
            }
        }
        
        if(indexPath.section == 0){
            self.performSegueWithIdentifier("fromSearchToProfile", sender: self)
        }else if (indexPath.section == 1){
            self.performSegueWithIdentifier("searchToEntriesByTag", sender: self)
        }else{
            self.performSegueWithIdentifier("fromSearchToEntryView", sender: self)
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func filterContentForSearchText(searchText: String) {
        self.searchResultsForUsers = self.allUsers.filter({(object: PFObject) -> Bool in
            var user = object as PFUser
            var userName = user.username as NSString
            userName = userName.lowercaseString
            return userName.containsString(searchText.lowercaseString)
        })
        
        self.searchResultsForTags = self.allTags.filter({(object: PFObject) -> Bool in
            var tag = object["tag"] as NSString
            tag = tag.lowercaseString
            return tag.containsString(searchText.lowercaseString)
        })
        
        self.searchResultsForEntries = self.allEntries.filter({(object: PFObject) -> Bool in
            var title = object["title"] as NSString
            title = title.lowercaseString
            return title.containsString(searchText.lowercaseString)
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
    
    func searchDisplayControllerDidEndSearch(controller: UISearchDisplayController) {
        messageLabel.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "fromSearchToEntryView"{
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.objectToPass
        }
        
        if (segue.identifier == "fromSearchToProfile"){
            let vc = segue.destinationViewController as ProfileViewController
            vc.currentUser = self.objectToPass as PFUser
        }
        if (segue.identifier == "searchToEntriesByTag"){
            let vc = segue.destinationViewController as EntriesByTagViewController
            vc.currentTag = self.selectedTag
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
