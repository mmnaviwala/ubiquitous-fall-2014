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
    
   // let cellIdentifier = "cellIdentifier"
    
    var virtualNameDictionary = Dictionary<String,String>()
    var keyArray = Array <String>()
    var valueArray = Array<String>()
    
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
        
        
        for (key,value)in virtualNameDictionary
        {
            keyArray.append(key)
            valueArray.append(value)
           // println("\(key)   \(value)")
        }
        
        self.tableView?.reloadData()
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Register the UITableViewCell class with the tableView
    
        
       //self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "displayCell")
        
        
        
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
        
        return self.keyArray.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = self.tableView?.dequeueReusableCellWithIdentifier("displayCell") as VirtualNameTableViewCell
       // var row = indexPath.row
        
        cell.backgroundColor = UIColor.clearColor()
        

        
         cell.keyword.text = self.keyArray[indexPath.row]
         cell.virtualName.text = self.valueArray[indexPath.row]
        
        //cell.keyword.text = " "
       //cell.virtualName.text = " "
        
        
        
        return cell
        
    }



}
