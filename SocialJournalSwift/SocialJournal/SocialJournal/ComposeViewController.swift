//
//  ComposeViewController.swift
//  SocialJournal
//
//  Created by Gabe on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit
import CoreLocation

class ComposeViewController: UIViewController, CLLocationManagerDelegate {
    var button: HamburgerButton! = nil
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    @IBOutlet weak var titleText: UITextField!    
    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var addMediaButton: UIButton!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var heartCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()

        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem

        self.titleText.layer.borderWidth = 3.0
        self.contentText.layer.borderWidth = 3.0
        self.mediaView.layer.borderWidth = 3.0
        self.addMediaButton.layer.borderWidth = 3.0
        self.profileImageView.layer.cornerRadius = 15.0
        
        self.titleText.layer.cornerRadius = 15.0
        self.contentText.layer.cornerRadius = 15.0
        self.mediaView.layer.cornerRadius = 15.0
        self.addMediaButton.layer.cornerRadius = 15.0
        self.profileImageView.layer.cornerRadius = 15.0
        
        self.titleText.layer.borderColor = UIColor(red: 140.0/255, green: 168.0/255, blue: 41.0/255, alpha: 1.0).CGColor
        self.contentText.layer.borderColor = UIColor(red: 140.0/255, green: 168.0/255, blue: 41.0/255, alpha: 1.0).CGColor
        self.mediaView.layer.borderColor = UIColor(red: 140.0/255, green: 168.0/255, blue: 41.0/255, alpha: 1.0).CGColor
        self.addMediaButton.layer.borderColor = UIColor(red: 140.0/255, green: 168.0/255, blue: 41.0/255, alpha: 1.0).CGColor
        self.profileImageView.layer.borderColor = UIColor(red: 140.0/255, green: 168.0/255, blue: 41.0/255, alpha: 1.0).CGColor
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMedia(sender: AnyObject) {
        
    }
/*
 * Method: getTagsFromTitleAndContent()
 * pass text to this method and it will return an array of hashtags
 * a hashtag is any of the following:
 * #yes #YESyesyes # no #n o #YesYes
 * no whitespace in a hashtag
 */
    func getTagsFromTitleAndContent() -> Array<String> {
        //get the tags here, if no tags return an empty array ... not nil
        var result = [String]();

        //initialize the arrays
        var titleTags = self.titleText.text.componentsSeparatedByString(" ")
        var contentTags = self.contentText.text.componentsSeparatedByString(" ")
        var allTags = titleTags + contentTags
        
        var tagDictionary = [String: Int]()
    
        for word in allTags{
            if countElements(word) != 0{
                var temp = (word as NSString).substringToIndex(1)
                if (temp == "#" && countElements(word) > 1 &&
                    word.substringFromIndex(advance(word.startIndex, 1)).rangeOfString("#") == nil &&
                    tagDictionary[word] == nil){
                    
                    tagDictionary[word] = allTags.count
                    result.append(word);
                    //println(word)
                }
            }
        }
        println(result)
        return result;
    }
    
    func saveTagsFromPost(entry:PFObject, tags:Array<String>) {
        let tags = getTagsFromTitleAndContent()
        if (!tags.isEmpty) {
            for tag in tags {
                var query = PFQuery(className: "Tags")
                
                query.whereKey("tag", equalTo: tag)
                query.getFirstObjectInBackgroundWithBlock {
                    (foundTag: PFObject!, error: NSError!) -> Void in
                    if foundTag != nil {
                        var newTag = PFObject(className: "Tags")
                        
                        newTag["tag"] = tag
                        newTag.save()
                        
                        var newTagMapEntry = PFObject(className: "TagMap")
                        
                        newTagMapEntry["entry"] = entry
                        newTagMapEntry["tag"] = newTag
                        newTagMapEntry.saveEventually()
                    } else {
                        var newTagMapEntry = PFObject(className: "TagMap")
                        
                        newTagMapEntry["entry"] = entry
                        newTagMapEntry["tag"] = foundTag
                        newTagMapEntry.saveEventually()
                    }
                }
                
            }
        }
    }
    
    
    @IBAction func postNewEntry(sender: AnyObject) {
        var newEntry = PFObject(className: "Entry")
        newEntry["content"] = self.contentText.text
        newEntry["user"] = PFUser.currentUser()
        newEntry["title"] = self.titleText.text
        newEntry["location"] = PFGeoPoint(latitude:(NSString(string: self.locationManager.location.coordinate.latitude.description)).doubleValue,
                                          longitude:(NSString(string: self.locationManager.location.coordinate.longitude.description)).doubleValue)
        if newEntry.save() {  //Will save synchronously, might need to add spinner for the entire if statement
            saveTagsFromPost(newEntry, tags: getTagsFromTitleAndContent())
        }
        
        println("Latitude: \(self.locationManager.location.coordinate.longitude.description)")
        println("Longitude: \(self.locationManager.location.coordinate.longitude.description)")
    }
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //println("updating location")
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                //println(pm.locality);
            }
        })
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
