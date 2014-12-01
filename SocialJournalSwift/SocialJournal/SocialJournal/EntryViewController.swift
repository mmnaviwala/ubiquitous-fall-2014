//
//  EntryViewController.swift
//  SocialJournal
//
//  Created by James Garcia on 11/19/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var showCommentsVisualView: UIVisualEffectView!
    var showCommentsToggle = true
    @IBOutlet weak var commentsTable: UITableView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var heartLike: UIButton!
    @IBOutlet weak var heartCount: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var dateWeekday: UILabel!
    @IBOutlet weak var dateDay: UILabel!
    @IBOutlet weak var dateMonth: UILabel!
    @IBOutlet weak var dateYear: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    var entry = PFObject(className: "Entry")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userProfilePicture.layer.cornerRadius = 50
        self.userProfilePicture.layer.masksToBounds = true
        
        var eachUser:PFObject = entry["user"] as PFObject
        var actualUser:PFUser = eachUser.fetchIfNeeded() as PFUser
        
        self.username.text = actualUser.username
        //        cell.userProfilePicture.image =
        
        //        if(favorited) {
        //            cell.hearted.image =
        //        }
        var entryTitle:String = entry["title"] as String!
        var entryText:String = entry["content"] as String!
        
        self.heartCount.text = String(ParseQueries.getHeartCountForEntry(self.entry))
        self.postTitle.text = entryTitle
        self.postBody.text = entryText
        assignDate(self.entry.createdAt)

        self.postBody.textColor = UIColor.whiteColor()
        self.postBody.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        
        showCommentsVisualView.layer.borderWidth = 1.0
        showCommentsVisualView.layer.borderColor = UIColor.whiteColor().CGColor
        

        // Do any additional setup after loading the view.
    }
    
    func assignDate(date:NSDate) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        self.dateWeekday.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        self.dateDay.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
        self.dateMonth.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY")
        self.dateYear.text = dateFormatter.stringFromDate(date)
    }

    @IBAction func touchShare(sender: AnyObject) {
        let firstActivityItem = entry["title"] as String!
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.shareButton
        activityViewController.popoverPresentationController?.sourceRect = CGRectMake(self.shareButton.frame.width/2, 0, 0, 0)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)

    }
    
    @IBAction func heartPost(sender: AnyObject) {
        println("I like this post")
        
        let image = UIImage(named: "HeartRed") as UIImage?
        self.heartLike.setImage(image, forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func commentButtonClicked(sender: UIButton) {
        var currentFrame = showCommentsVisualView.frame
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        
        if (showCommentsToggle){
            showCommentsVisualView.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y-300, currentFrame.size.width, currentFrame.size.height+300)
            sender.layer.backgroundColor = UIColor.blackColor().CGColor
            sender.setTitle("Hide Comments", forState: UIControlState.Normal)
            showCommentsToggle = !showCommentsToggle
        }else{
            showCommentsVisualView.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y+300, currentFrame.size.width, currentFrame.size.height-300)
            sender.layer.backgroundColor = UIColor.clearColor().CGColor
            sender.setTitle("Show Comments", forState: UIControlState.Normal)
            showCommentsToggle = !showCommentsToggle
        }
        
        UIView.commitAnimations()
    }
    
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.commentsTable.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CommentCell = tableView.dequeueReusableCellWithIdentifier("commentCell") as CommentCell
        cell.userName.text = "username here"
        cell.theComment.text = "comment\nsupports 4 lines at most\nlast line"
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 100
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
