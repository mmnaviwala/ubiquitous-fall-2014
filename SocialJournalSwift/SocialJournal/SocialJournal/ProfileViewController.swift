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
    
    var button: HamburgerButton! = nil
    @IBOutlet weak var theCollectionView: UICollectionView!
    var currentCollectionViewDataArray = [""]
    var followingArray = ["@theMightMidget", "@kungFuPanda", "@theCerealKiller", "@spaceMonkeyMafia", "@theMuffinStuffer"]
    var followersArray = ["@frenchToastMafia", "@crackSmokingMonkey", "@awesomeD", "@madIsotope", "@fartMonster", "@dropItLikeItsHot", "@trialAndError", "@kungFuPanda"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button color can be changed in HamburgerButton.swift
        // "strokeColor" on line 43. By default its white
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem

        
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        
        currentCollectionViewDataArray = followingArray // following is the default selection
        
        currentUserProfilePicture.layer.cornerRadius = currentUserProfilePicture.frame.size.width / 2;
        currentUserProfilePicture.clipsToBounds = true;
        currentUserProfilePicture.layer.borderWidth = 6.0
        currentUserProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor;
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
        return currentCollectionViewDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as collectionViewCell
        cell.userNameLabel.text = currentCollectionViewDataArray[indexPath.row]
         cell.layer.cornerRadius = 6
         cell.layer.borderWidth = 1.0
         cell.layer.borderColor = UIColor.lightGrayColor().CGColor;
        
        return cell
    }
    
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
