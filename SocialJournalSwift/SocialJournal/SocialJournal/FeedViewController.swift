//
//  FeedViewController.swift
//  SocialJournal
//
//  Created by Muhammad Naviwala on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var selectFeedType: UISegmentedControl!
    @IBOutlet weak var leftImage: UIImageView!
    var button: HamburgerButton! = nil
    var allEntries:[(entry: PFObject, user: PFUser, userImage: UIImage?, likeCount: Int, userLiked: Bool, entryHeartBeat: Double)] = []
    var heartbeat = [(Double,PFObject)]()
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
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.attributedTitle = NSAttributedString(string:"Pull to refresh", attributes:
            [NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 18.0)!])
        refreshControl.addTarget(self, action: "fetchData", forControlEvents: UIControlEvents.ValueChanged)
        feedTableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchData()
        feedTableView.reloadData()
        feedTableView.reloadInputViews()
    }
    
    func setupTheHamburgerIcon() {
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    func fetchData() {
        var query = ParseQueries.queryForEntries(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                for var i = 0; i < objects.count; i++ {
                    //get user
                    var user = objects[i]["user"] as PFUser
                    user.fetchIfNeeded()
                    
                    //get profile image
                    var userImageFile:PFFile? = user["profileImage"] as? PFFile
                    var imageData = userImageFile?.getData()
                    var userImage:UIImage? = nil
                    if imageData != nil {
                        userImage = UIImage(data: imageData!)!
                    }
                    //get number of likes
                    var query = PFQuery(className: "Activity")
                    query.whereKey("entry", equalTo: objects[i])
                    query.whereKey("type", equalTo: "like")
                    var likeCount = query.countObjects()
                    // self.assignHeartBeatTEST(objects[i] as PFObject)
                    
                    //does user like
                    var userLikeQuery = PFQuery(className: "Activity")
                    userLikeQuery.whereKey("entry", equalTo: objects[i])
                    userLikeQuery.whereKey("fromUser", equalTo: PFUser.currentUser())
                    userLikeQuery.whereKey("type", equalTo: "like")
                    var likes = query.countObjects()
                    var userLiked = false
                    if likes > 0 {
                        userLiked = true
                    }
                    var hotness = self.assignHeartBeatTEST(likeCount, entry: objects[i] as PFObject)
                    self.allEntries.insert((entry: objects[i] as PFObject, user: user, userImage: userImage, likeCount: likeCount, userLiked: userLiked, entryHeartBeat: hotness), atIndex: i)
                    
                }
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            self.feedTableView.reloadData()

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
        
        if !self.allEntries.isEmpty {
            cell.username.text = self.allEntries[indexPath.section].user.username

            
            if (self.allEntries[indexPath.section].userImage != nil){
                cell.userProfilePicture.image = self.allEntries[indexPath.section].userImage!
            }else{
                cell.userProfilePicture.image = UIImage(named: "defaultUser")
            }
            
            
            if self.allEntries[indexPath.section].userLiked {
                cell.hearted.tintColor = UIColor.redColor()
                cell.hearted.image = UIImage(named: "HeartRed")
            }
            else{
                cell.hearted.tintColor = UIColor.whiteColor()
                cell.hearted.image = UIImage(named: "HeartWhite")
            }
            cell.postTitle.text = self.allEntries[indexPath.section].entry["title"] as String!
            cell.postBody.text = self.allEntries[indexPath.section].entry["content"] as String!
            cell.heartCount.text = String(self.allEntries[indexPath.section].likeCount)
            
            assignDate(self.allEntries[indexPath.section].entry.createdAt, cell: cell)
        }
        return cell
    }
    
    @IBAction func feedSelected(sender: AnyObject) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            allEntries.sort({$0.entry.createdAt.timeIntervalSince1970 > $1.entry.createdAt.timeIntervalSince1970})
            
            self.feedTableView.reloadData()
            self.feedTableView.reloadInputViews()

        case 1:
            allEntries.sort({$0.entryHeartBeat > $1.entryHeartBeat})
            
            self.feedTableView.reloadData()
            self.feedTableView.reloadInputViews()
            
        default:
            break;
        }
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
    
    
    func assignHeartBeatTEST(entryLikeCount: Int, entry: PFObject) -> Double{
        var heartInt = Double(entryLikeCount)
        var order = log10((max(heartInt, 1)))
        var seconds = entry.createdAt.timeIntervalSince1970 - 1134028003
        var format = (Double(order) + (seconds / 45000))
        var hotness = round(format * 100) / 100.0
//        entry["heartBeat"] = hotness
        return hotness
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
            vc.entry = self.allEntries[selectedSection].entry as PFObject
        }
    }

    
}

