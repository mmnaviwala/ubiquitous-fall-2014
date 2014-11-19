//
//  ComposeViewController.swift
//  SocialJournal
//
//  Created by Gabe on 11/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    var button: HamburgerButton! = nil
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    @IBOutlet weak var titleText: UITextField!    
    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var addMediaButton: UIButton!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var heartCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem


        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMedia(sender: AnyObject) {
        
    }
    
    @IBAction func postNewEntry(sender: AnyObject) {
        var newPost = PFObject(className: "Entry")
        newPost["content"] = self.contentText.text;
//        newPost["user"] = PFUser.currentUser()
        newPost["title"] = self.titleText.text;
        println("Title: " + self.titleText.text);
        println("Content: " + self.contentText.text);
        
        //add for geolat and geolong
        //add for image and video
    }
    
    func toggle(sender: AnyObject!) {
        self.button.showsMenu = !self.button.showsMenu
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
