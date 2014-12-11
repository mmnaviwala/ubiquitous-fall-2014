//
//  MediaViewController.swift
//  SocialJournal
//
//  Created by James Garcia on 12/10/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "")
        let request = NSURLRequest(URL: url!)
        mediaWebView.loadRequest(request)
        if(mediaImageView.image == nil){
            UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
                var basketTopFrame = CGRectMake(0.0, self.view.frame.height, self.view.frame.width, self.view.frame.height)
                basketTopFrame.origin.y -= basketTopFrame.size.height
                self.mediaWebView.frame = basketTopFrame
                
                }, completion: { finished in
                    println("Basket doors opened!")
            })
        }
        
        if(url == ""){
            UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
                var basketTopFrame = CGRectMake(0.0, self.view.frame.height, self.view.frame.width, self.view.frame.height)
                basketTopFrame.origin.y -= basketTopFrame.size.height
                self.mediaWebView.frame = basketTopFrame
                
                }, completion: { finished in
                    println("Basket doors opened!")
            })
        }

        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
