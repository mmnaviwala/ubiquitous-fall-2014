//
//  ProfileViewController.swift
//  PlayingWithAnimations
//
//  Created by Muhammad Naviwala on 11/15/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var currentUserProfilePicture: UIImageView!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var theCollectionView: UICollectionView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var button: HamburgerButton! = nil
    
    // this needs to be set from somewhere else
    // so when other profiles, we can set the "currentUser"
    // to whatever user is selected
    var currentUser:PFUser = PFUser()

    var currentCollectionViewDataArray = []
    
    var followingArray = []
    var followersArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.currentUser.objectId == nil){
            self.currentUser = PFUser.currentUser()
        }
        
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        self.currentUserName.text = "@" + currentUser.username
        
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        
        currentCollectionViewDataArray = followingArray // following is the default selection
        
        currentUserProfilePicture.layer.cornerRadius = currentUserProfilePicture.frame.size.width / 2;
        currentUserProfilePicture.clipsToBounds = true;
        currentUserProfilePicture.layer.borderWidth = 6.0
        currentUserProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor;
        
        self.noDataFoundLabel.hidden = true
        if (currentUser.objectId == PFUser.currentUser().objectId){
            self.followButton.hidden = true
        }else{
            self.followButton.hidden = false
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.followersArray = ParseQueries.getFollowers(self.currentUser)
            self.theCollectionView.reloadData()
        })
        
    }
    
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentClicked(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentCollectionViewDataArray = followingArray
        case 1:
            currentCollectionViewDataArray = followersArray
        default:
            break;
        }
        theCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (currentCollectionViewDataArray.count == 0){
            self.noDataFoundLabel.hidden = false
        }else{
            self.noDataFoundLabel.hidden = true
        }
        return currentCollectionViewDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as collectionViewCell
        if (currentCollectionViewDataArray != []){
            var eachObject: PFObject = currentCollectionViewDataArray[indexPath.row] as PFObject
            var eachUser:PFObject = eachObject["user"] as PFObject
            var actualUser:PFUser = eachUser.fetchIfNeeded() as PFUser
            cell.userNameLabel.text = actualUser.username
        }
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor;
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToProfileFromCollectionCell"){
            
            let indexPaths : NSArray = self.theCollectionView.indexPathsForSelectedItems()!
            let indexPath : NSIndexPath = indexPaths[0] as NSIndexPath
            
            var eachObject: PFObject = currentCollectionViewDataArray[indexPath.row] as PFObject
            var eachUser:PFObject = eachObject["user"] as PFObject
            var actualUser:PFUser = eachUser.fetchIfNeeded() as PFUser
            
            let vc = segue.destinationViewController as ProfileViewController
            vc.currentUser = actualUser
        }
    }
    
    
    
    
    @IBAction func followButtonClicked(sender: UIButton) {
        // Set the button so it says unfollow
        if(sender.titleForState(UIControlState.Normal) == "Follow"){
            sender.setTitle("Unfollow", forState: UIControlState.Normal)
            sender.layer.backgroundColor = UIColor.redColor().CGColor
        }else{
            sender.setTitle("Follow", forState: UIControlState.Normal)
            sender.layer.backgroundColor = UIColor(red: 39.0/255, green: 154.0/255, blue: 216.0/255, alpha: 1.0).CGColor
        }
    }
    
    // Lets worry about this functionality later on
    @IBAction func addRemovePerson(sender: AnyObject) {
        if (sender.backgroundImageForState(UIControlState.Normal) == UIImage(named: "AddPerson")){
            sender.setBackgroundImage(UIImage(named: "RemovePerson"), forState: .Normal)
            sender.layer.backgroundColor = UIColor.redColor().CGColor
        }else {
            sender.setBackgroundImage(UIImage(named: "AddPerson"), forState: .Normal)
            sender.layer.backgroundColor = UIColor(red: 39.0/255, green: 154.0/255, blue: 216.0/255, alpha: 1.0).CGColor
        }
    }
}
