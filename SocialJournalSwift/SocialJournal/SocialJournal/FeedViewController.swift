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
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var currentEntry = PFObject(className: "Entry")
//    var something:PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        
        self.spinner.startAnimating()
        var query = ParseQueries.queryForEntries(PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            self.spinner.stopAnimating()
            if error == nil {
                self.allEntries = objects
                self.feedTableView.reloadData()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "feedToEntry"{
            var selectedRowIndexPath: NSIndexPath = self.feedTableView.indexPathForSelectedRow()!
            var selectedSection: NSInteger = selectedRowIndexPath.section
            
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.allEntries[selectedSection] as PFObject
        }
    }

    
}

