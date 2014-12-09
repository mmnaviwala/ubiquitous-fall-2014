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
        getVirtualNamesFromNSUserDefaults()
    }
    
    @IBAction func saveChange(sender: AnyObject) {
        //check if its an empty virtual name
        if keyword.text != "" && virtualName.text != ""{
            self.virtualNameDictionary[keyword.text] = virtualName.text
        }else{
            let alertController = UIAlertController(title: "Sorry", message:
                "Virtual names and their replacements cannot be empty.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        //reset both arrays to avoid extra elements
        self.keyArray.removeAll(keepCapacity: false)
        self.valueArray.removeAll(keepCapacity: false)
        
        //refill both arrays
        for (key, value) in virtualNameDictionary{
            self.keyArray.append(key)
            self.valueArray.append(value)
        }
        
        //reset text fields
        self.keyword.text = ""
        self.virtualName.text = ""
        
        //println(self.virtualNameDictionary)
        saveToNSUserDefaults()
        self.tableView?.reloadData()
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        self.virtualNameDictionary.removeAll(keepCapacity: false)
        self.tableView?.reloadData()
    }
    
    func getVirtualNamesFromNSUserDefaults(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let virtualNames = userDefaults.objectForKey("virtualNamesDictionary") as? Dictionary<String,String>{
            self.virtualNameDictionary = virtualNames
            //refill both arrays
            for (key, value) in virtualNameDictionary{
                self.keyArray.append(key)
                self.valueArray.append(value)
            }
        }
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
        
        cell.keyword.text = self.keyArray[indexPath.row]
        cell.virtualName.text = self.valueArray[indexPath.row]
        return cell
    }
}