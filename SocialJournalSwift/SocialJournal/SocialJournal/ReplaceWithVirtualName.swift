//
//  ReplaceWithVirtualName.swift
//  SocialJournal
//
//  Created by Xiaolu Zhang on 12/2/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class ReplaceWithVirtualName: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var keyword: UITextField!
    
    @IBOutlet weak var virtualName: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var virtualNameDictionary = Dictionary<String,String>()
    var keyArray = Array <String>()
    
    var valueArray = Array<String>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveChange(sender: AnyObject) {
        
        
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
             println("\(key)   \(value)")
        }
        
        self.tableView?.reloadData()
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
        
        //cell.keyword.text = "nmb "
        //cell.virtualName.text = " nmb"
        
        
        return cell
        
    }
    
    

}
