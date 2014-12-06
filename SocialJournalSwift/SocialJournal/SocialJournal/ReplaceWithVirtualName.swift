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
        self.virtualNameDictionary[keyword.text] = virtualName.text
        
        //reset both arrays to avoid extra elements
        keyArray.removeAll(keepCapacity: false)
        valueArray.removeAll(keepCapacity: false)
        
        //refill both arrays
        for (key, value) in virtualNameDictionary{
            keyArray.append(key)
            valueArray.append(value)
        }
        
        //reset text fields
        self.keyword.text = ""
        self.virtualName.text = ""
        
        //println(self.virtualNameDictionary)
        saveToNSUserDefaults()
        self.tableView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func saveToNSUserDefaults(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.virtualNameDictionary, forKey: "virtualNamesDictionary")
        userDefaults.synchronize()
    }
    
    // UITableViewDataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countElements(virtualNameDictionary)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView?.dequeueReusableCellWithIdentifier("displayCell") as VirtualNameTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        cell.keyword.text = keyArray[indexPath.row]
        cell.virtualName.text = valueArray[indexPath.row]
        return cell
    }
}