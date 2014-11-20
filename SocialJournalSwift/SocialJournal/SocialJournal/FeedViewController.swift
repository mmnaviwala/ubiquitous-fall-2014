//
//  FeedViewController.swift
//  SocialJournal
//
//  Created by Muhammad Naviwala on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var leftImage: UIImageView!
    var button: HamburgerButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:feedCellTableViewCell=tableView.dequeueReusableCellWithIdentifier("feedCell") as feedCellTableViewCell
        
        cell.username.text = "anonDawg"
//        cell.userProfilePicture.image =

//        if(favorited) {
//            cell.hearted.image =
//        }

        cell.heartCount.text = "9999"
        cell.postTitle.text = "Post Title"
        cell.postBody.text = "Post Body"
        cell.dateWeekday.text = "Monday"
        cell.dateDay.text = "24"
        cell.dateMonth.text = "December"
        cell.dateYear.text = "2014"
        return cell
    }
    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
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
            let vc = segue.destinationViewController as EntryViewController
        }
    }

    
}

