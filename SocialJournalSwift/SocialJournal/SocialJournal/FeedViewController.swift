//
//  FeedViewController.swift
//  SocialJournal
//
//  Created by Muhammad Naviwala on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var leftImage: UIImageView!
    var button: HamburgerButton! = nil
    var allEntries = []
    var heartbeat = [0.0]
    var allUsers:[PFUser?] = []
    var allUsersProfileImage:[UIImage?] = []
    var allLikes:[Int] = []
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var refreshControl:UIRefreshControl!
    
    var currentEntry = PFObject(className: "Entry")
//    var something:PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheHamburgerIcon()
        self.spinner.center = self.view.center
        self.spinner.startAnimating()
        fetchData()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.attributedTitle = NSAttributedString(string:"Pull to refresh", attributes:
            [NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 18.0)!])
        refreshControl.addTarget(self, action: "fetchData", forControlEvents: UIControlEvents.ValueChanged)
        feedTableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        feedTableView.reloadData()
        feedTableView.reloadInputViews()
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
    
    func fetchData() {
        var query = ParseQueries.queryForEntries(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.allEntries = objects
                self.feedTableView.reloadData()
                for entry:PFObject in self.allEntries as [PFObject] {
                    //get user
                    var user = entry["user"] as PFUser
                    user.fetchIfNeeded()
                    self.allUsers.append(user)
                    //get profile image
                    var userImageFile:PFFile? = user["profileImage"] as? PFFile
                    var imageData = userImageFile?.getData()
                    if imageData != nil {
                        self.allUsersProfileImage.append(UIImage(data: imageData!)!)
                    }else {
                        self.allUsersProfileImage.append(nil)
                    }
                    //get like bool
                    var query = PFQuery(className: "Activity")
                    query.whereKey("entry", equalTo: entry)
                    query.whereKey("type", equalTo: "like")
                    var likes = query.findObjects()
                    self.allLikes.append(likes.count)
                }
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
            if((self.refreshControl) != nil){
                self.refreshControl.endRefreshing()
            }
            
            if(self.spinner.isAnimating()){
                self.spinner.stopAnimating()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    
    
    // UITableViewDataSource methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.feedTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
            
            cell.username.text = self.allUsers[indexPath.section]!.username
            //set image
            
            if self.allUsersProfileImage[indexPath.section] != nil {
                cell.userProfilePicture.image = self.allUsersProfileImage[indexPath.section]
            }
            
            var query = PFQuery(className: "Activity")
            query.whereKey("entry", equalTo: entry)
            query.whereKey("fromUser", equalTo: PFUser.currentUser())
            query.whereKey("type", equalTo: "like")
            var likes = query.findObjects()
            
            if likes.count > 0 {
                cell.hearted.tintColor = UIColor.redColor()
                cell.hearted.image = UIImage(named: "HeartRed")
            }
            
            var entryTitle:String = entry["title"] as String!
            var entryText:String = entry["content"] as String!
            
            
            
            cell.heartCount.text = String(self.allLikes[indexPath.section])
            cell.postTitle.text = entryTitle
            cell.postBody.text = entryText
            assignDate(entry.createdAt, cell: cell)
            assignHeartbeatRanking(entry.createdAt, heartCount: String(self.allLikes[indexPath.section]))
        
        }
        
        return cell
    }
    
    func assignDate(date:NSDate, cell:feedCellTableViewCell) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        cell.dateWeekday.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        cell.dateDay.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
        cell.dateMonth.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY")
        cell.dateYear.text = dateFormatter.stringFromDate(date)
    }
    
    func assignHeartbeatRanking(date:NSDate, heartCount:String) {
        
        var heartInt = (heartCount as NSString).doubleValue
        var order = log10((max(heartInt, 1)))
        var seconds = date.timeIntervalSince1970 - 1134028003
        var format = (Double(order) + (seconds / 45000))
        var hotness = round(format * 100) / 100.0
        
        if(heartbeat.count == 0){
            heartbeat.removeLast()
            heartbeat.append(hotness)
        }else{
            heartbeat.append(hotness)
        }
        
        sort(&heartbeat)
        
        for beats in heartbeat{
            println(beats)
        }
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "feedToEntry"{
            var selectedRowIndexPath: NSIndexPath = self.feedTableView.indexPathForSelectedRow()!
            var selectedSection: NSInteger = selectedRowIndexPath.section
            
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.allEntries[selectedSection] as PFObject
        }
    }

    
}

