//
//  ReplaceWithVirtualName.swift
//  SocialJournal
//
//  Created by Xiaolu Zhang on 11/25/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class ReplaceWithVirtualName: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var virtualName: UITextField!
    
    @IBOutlet var keyword: UITextField!
    
    let cellIdentifier = "cellIdentifier"
    
    var virtualNameDictionary = Dictionary<String,String>()
    
    @IBOutlet var tableView: UITableView?

   // @IBOutlet var displayChange: UITextView!
    
    @IBAction func save(sender: AnyObject) {

        
                
        for(key, value) in virtualNameDictionary
        {
            if(keyword.text == key)
            {
                virtualNameDictionary.removeValueForKey(key);
            }
        }
        
        virtualNameDictionary[keyword.text] = virtualName.text;
        
        
        keyword.text = ""
        virtualName.text = ""
    }


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



}
