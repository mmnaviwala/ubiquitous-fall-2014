//
//  MainCollectionViewController.swift
//  SocialJournal
//
//  Created by Gabe on 11/16/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    var hamburgerButton: HamburgerButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        
        // ==========
        // self.menuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // ==========
        
        self.hamburgerButton = HamburgerButton(frame: CGRectMake(20, 20, 54, 54))
        self.hamburgerButton.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
            
//        var barButtonItem:UIBarButtonItem! = UIBarButtonItem.init(customView: self.hamburgerButton)
//        self.navigationController?.navigationItem.rightBarButtonItem = barButtonItem
        
        var b = UIBarButtonItem(title: "Continue", style: .Plain, target: self, action: "toggle:")
        self.navigationController?.navigationItem.rightBarButtonItem = b
        
        self.menuButton = hamburgerButton
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    func toggle(sender: AnyObject!) {
        self.hamburgerButton.showsMenu = !self.hamburgerButton.showsMenu
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
