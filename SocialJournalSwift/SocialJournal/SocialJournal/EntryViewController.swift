//
//  EntryViewController.swift
//  SocialJournal
//
//  Created by James Garcia on 11/19/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var hearted: UIImageView!
    @IBOutlet weak var heartCount: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var dateWeekday: UILabel!
    @IBOutlet weak var dateDay: UILabel!
    @IBOutlet weak var dateMonth: UILabel!
    @IBOutlet weak var dateYear: UILabel!
    var entry = PFObject(className: "Entry")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userProfilePicture.layer.cornerRadius = 50
        self.userProfilePicture.layer.masksToBounds = true
        
        //Date
        var weekday: NSDateFormatter = NSDateFormatter()
        var day: NSDateFormatter = NSDateFormatter()
        var month: NSDateFormatter = NSDateFormatter()
        var year: NSDateFormatter = NSDateFormatter()
        weekday.setLocalizedDateFormatFromTemplate("EEEE")
        day.setLocalizedDateFormatFromTemplate("dd")
        month.setLocalizedDateFormatFromTemplate("MMMM")
        year.setLocalizedDateFormatFromTemplate("YYYY")
        var dateStringWeekday: NSString = weekday.stringFromDate(self.entry.createdAt)
        var dateStringDay: NSString = day.stringFromDate(self.entry.createdAt)
        var dateStringMonth: NSString = month.stringFromDate(self.entry.createdAt)
        var dateStringYear: NSString = year.stringFromDate(self.entry.createdAt)
        
        self.username.text = "anonDawg"
        //        cell.userProfilePicture.image =
        
        //        if(favorited) {
        //            cell.hearted.image =
        //        }
        var entryTitle:String = entry["title"] as String!
        var entryText:String = entry["content"] as String!
        
        self.heartCount.text = String(ParseQueries.getHeartCountForEntry(self.entry))
        self.postTitle.text = entryTitle
        self.postBody.text = entryText
        self.dateWeekday.text = dateStringWeekday
        self.dateDay.text = dateStringDay
        self.dateMonth.text = dateStringMonth
        self.dateYear.text = dateStringYear

        self.postBody.textColor = UIColor.whiteColor()
        self.postBody.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
