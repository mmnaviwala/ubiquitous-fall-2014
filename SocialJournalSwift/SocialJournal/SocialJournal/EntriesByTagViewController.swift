//
//  EntriesByTagViewController.swift
//  SocialJournal
//
//  Created by Matt Phillips on 12/10/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class EntriesByTagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var currentTag: String = ""
    var currentEntry = PFObject(className: "Entry")
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var entries: [PFObject] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        println(self.entries)
//        println(currentTag)
        fetchEntriesByTag(currentTag)
    }
    
    func fetchEntriesByTag(tag: String) {
        
        self.spinner.center = self.view.center
        self.spinner.startAnimating()
        
        var query = ParseQueries.queryForEntriesPerTag(tag)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
//                println(objects)
                for object in objects {
                    // self.entries.append(object as PFObject)
                    
//                    object.fetchIfNeededInBackgroundWithBlock{
//                        (theObject: PFObject!, error: NSError!) -> Void in
//                        if error == nil {
//                            self.entries.append(theObject)
//                        }
//                    }
                    
                    var entryObject = object["entry"] as PFObject
                    self.entries.append(entryObject.fetchIfNeeded())
                    
                }
//                println("Appending complete")
//                println(self.entries)
//                println("Entries by tag fetched")
                self.spinner.stopAnimating()

            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
            self.tableView.reloadData()
            if(self.spinner.isAnimating()){
                self.spinner.stopAnimating()
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentEntry = self.entries[indexPath.section] as PFObject
        self.performSegueWithIdentifier("entriesByTagToEntry", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.entries.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:feedCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("feedCell") as feedCellTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        if (self.entries != []){
            var entry:PFObject = self.entries[indexPath.section] as PFObject
            
            //set image
            var userImageFile:PFFile? = entry["profileImage"] as? PFFile
            userImageFile?.getDataInBackgroundWithBlock{
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    if imageData != nil {
                        cell.userProfilePicture.image = UIImage(data: imageData!)
                    }
                }
            }


            cell.postTitle.text = entry["title"] as String!
            cell.postBody.text = entry["content"] as String!
            assignDate(entry.createdAt, cell: cell)
            
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
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        var headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 1))
        headerView.backgroundColor = UIColor.clearColor()
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30.0
    }
    
    func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat{
        return 150
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "entriesByTagToEntry"{
            let vc = segue.destinationViewController as EntryViewController
            vc.entry = self.currentEntry as PFObject
        }
    }

}