//
//  ProfileViewController.swift
//  PlayingWithAnimations
//
//  Created by Muhammad Naviwala on 11/15/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var currentUserProfilePicture: UIImageView!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var theCollectionView: UICollectionView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var theTableView: UITableView!
    
    var button: HamburgerButton! = nil
    var allEntries = []
    
    var currentUser:PFUser = PFUser()

    var currentCollectionViewDataArray = []
    
    var followingArray = []
    var followersArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.currentUser.objectId == nil){
            self.currentUser = PFUser.currentUser()
        }
        
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        self.currentUserName.text = "@" + currentUser.username
        
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        
        currentCollectionViewDataArray = followingArray // following is the default selection
        
        currentUserProfilePicture.layer.cornerRadius = currentUserProfilePicture.frame.size.width / 2;
        currentUserProfilePicture.clipsToBounds = true;
        currentUserProfilePicture.layer.borderWidth = 6.0
        currentUserProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor;
        
        theTableView.hidden = true
        theCollectionView.hidden = false
        
        self.noDataFoundLabel.hidden = true
        if (currentUser.objectId == PFUser.currentUser().objectId){
            self.followButton.hidden = true
        }else{
            self.followButton.hidden = false
        }
        
        // ==========================================================
        // Get the followers
        self.spinner.startAnimating()
        var query = ParseQueries.queryForFollowers(self.currentUser)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            self.spinner.stopAnimating()
            if error == nil {
                self.followersArray = objects
                self.theCollectionView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        // ==========================================================
        // Get the following
        self.spinner.startAnimating()
        query = ParseQueries.queryForFollowing(self.currentUser)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            self.spinner.stopAnimating()
            if error == nil {
                self.followingArray = objects
                self.theCollectionView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

        // ==========================================================
        // Get the entries
        self.spinner.startAnimating()
        query = ParseQueries.queryForEntries(self.currentUser)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            self.spinner.stopAnimating()
            if error == nil {
                self.allEntries = objects
                self.theTableView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }
    

    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentClicked(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentCollectionViewDataArray = followingArray
            theTableView.hidden = true
            theCollectionView.hidden = false
            theCollectionView.reloadData()
        case 1:
            currentCollectionViewDataArray = followersArray
            theTableView.hidden = true
            theCollectionView.hidden = false
            theCollectionView.reloadData()
        case 2:
            theTableView.hidden = false
            theCollectionView.hidden = true
            theTableView.reloadData()
        default:
            break;
        }
    }
    
    
//    ==================================================================================================
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (currentCollectionViewDataArray.count == 0){
            self.noDataFoundLabel.hidden = false
        }else{
            self.noDataFoundLabel.hidden = true
        }
        return currentCollectionViewDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as collectionViewCell
        if (currentCollectionViewDataArray != []){
            var eachObject: PFObject = currentCollectionViewDataArray[indexPath.row] as PFObject
            var eachUser:PFObject
            if (currentCollectionViewDataArray == followersArray){
                eachUser = eachObject["fromUser"] as PFObject
            }else{
                eachUser = eachObject["toUser"] as PFObject
            }
            var actualUser:PFUser = eachUser.fetchIfNeeded() as PFUser
            cell.userNameLabel.text = actualUser.username
        }
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor;
        
        return cell
    }
    
    
    
//    ==================================================================================================
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.theTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (allEntries.count == 0){
            self.noDataFoundLabel.hidden = false
        }else{
            self.noDataFoundLabel.hidden = true
        }
        return self.allEntries.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:feedCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("feedCell") as feedCellTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        if (self.allEntries != []){
            var entry:PFObject = self.allEntries[indexPath.section] as PFObject
            
            //Date
            var weekday: NSDateFormatter = NSDateFormatter()
            var day: NSDateFormatter = NSDateFormatter()
            var month: NSDateFormatter = NSDateFormatter()
            var year: NSDateFormatter = NSDateFormatter()
            weekday.setLocalizedDateFormatFromTemplate("EEEE")
            day.setLocalizedDateFormatFromTemplate("dd")
            month.setLocalizedDateFormatFromTemplate("MMMM")
            year.setLocalizedDateFormatFromTemplate("YYYY")
            var dateStringWeekday: NSString = weekday.stringFromDate(entry.createdAt)
            var dateStringDay: NSString = day.stringFromDate(entry.createdAt)
            var dateStringMonth: NSString = month.stringFromDate(entry.createdAt)
            var dateStringYear: NSString = year.stringFromDate(entry.createdAt)
            
            cell.username.text = "anonDawg"
            //        cell.userProfilePicture.image =
            
            //        if(favorited) {
            //            cell.hearted.image =
            //        }
            var entryTitle:String = entry["title"] as String!
            var entryText:String = entry["content"] as String!
            
            cell.heartCount.text = String(ParseQueries.getHeartCountForEntry(entry))
            cell.postTitle.text = entryTitle
            cell.postBody.text = entryText
            cell.dateWeekday.text = dateStringWeekday
            cell.dateDay.text = dateStringDay
            cell.dateMonth.text = dateStringMonth
            cell.dateYear.text = dateStringYear
            
        }
        
        return cell
    }
    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        var headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 1))
        headerView.backgroundColor = UIColor.clearColor()
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30.0
    }
    
    func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 150
    }
    
    
    
    
//    ==================================================================================================
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToProfileFromCollectionCell"){
            
            let indexPaths : NSArray = self.theCollectionView.indexPathsForSelectedItems()!
            let indexPath : NSIndexPath = indexPaths[0] as NSIndexPath
            
            var eachObject: PFObject = currentCollectionViewDataArray[indexPath.row] as PFObject
            var eachUser:PFObject = eachObject["fromUser"] as PFObject
            var actualUser:PFUser = eachUser.fetchIfNeeded() as PFUser
            
            let vc = segue.destinationViewController as ProfileViewController
            vc.currentUser = actualUser
        }
        
        if segue.identifier == "feedToEntry"{
            var selectedRowIndexPath: NSIndexPath = self.theTableView.indexPathForSelectedRow()!
            var selectedSection: NSInteger = selectedRowIndexPath.section
            
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.allEntries[selectedSection] as PFObject
        }
    }
    
    @IBAction func followButtonClicked(sender: UIButton) {
        // Set the button so it says unfollow
        if(sender.titleForState(UIControlState.Normal) == "Follow"){
            sender.setTitle("Unfollow", forState: UIControlState.Normal)
            sender.layer.backgroundColor = UIColor.redColor().CGColor
        }else{
            sender.setTitle("Follow", forState: UIControlState.Normal)
            sender.layer.backgroundColor = UIColor(red: 39.0/255, green: 154.0/255, blue: 216.0/255, alpha: 1.0).CGColor
        }
    }
    
}
