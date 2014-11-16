//
//  ProfileViewController.swift
//  PlayingWithAnimations
//
//  Created by Muhammad Naviwala on 11/15/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var button: HamburgerButton! = nil
    @IBOutlet weak var theCollectionView: UICollectionView!
    var titleArray = ["So this programmer goes out on a date with a hot chick", "What is the difference between snowmen and snowwomen? Snowballs", "What do you call a bear with no teeth? A gummy bear", "How do astronomers organize a party? They planet", "Whats the object-oriented way to become wealthy? Inheritance", "How many prolog programmers does it take to change a lightbulb? Yes", "To understand what recursion is, you must first understand recursion."]
    
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
    }
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as collectionViewCell
        cell.title.text = titleArray[indexPath.row]
        cell.previewText.text = "The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox. Bright vixens jump; dozy fowl quack. Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. Sex-charged fop blew my junk TV quiz. How quickly daft jumping zebras vex."
        // cell.layer.cornerRadius = 10
        // cell.layer.borderWidth = 1.0
        // cell.layer.borderColor = UIColor.grayColor().CGColor;
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSizeMake(-5, 5);
        cell.layer.shadowRadius = 5;
        cell.layer.shadowOpacity = 0.7;
        
        cell.userProfilePicture.layer.cornerRadius = cell.userProfilePicture.frame.size.width / 2;
        cell.userProfilePicture.clipsToBounds = true;
        cell.userProfilePicture.layer.borderWidth = 3.0
        cell.userProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor;
        
        var gradientMaskLayer:CAGradientLayer = CAGradientLayer()
        gradientMaskLayer.frame = cell.whiteView.bounds
        gradientMaskLayer.colors = [UIColor.clearColor().CGColor!, UIColor.blackColor().CGColor!]
        gradientMaskLayer.locations = [0.0, 0.05]
        cell.whiteView.layer.mask = gradientMaskLayer
        
        return cell
    }
    
}
