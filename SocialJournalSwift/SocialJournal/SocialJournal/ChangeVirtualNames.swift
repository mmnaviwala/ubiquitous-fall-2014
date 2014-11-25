//
//  ChangeVirtualNames.swift
//  SocialJournal
//
//  Created by Xiaolu Zhang on 11/24/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class ChangeVirtualNames: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "cellIdentifier"
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the UITableViewCell class with the tableView
        
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        // Setup table data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView?.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        //var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        //cell.textLabel.text = self.tableData[indexPath.row]
        
        return cell
    }
    
   
    

    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    

}
