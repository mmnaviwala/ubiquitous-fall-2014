//
//  SignInController.swift
//  PlayingWithAnimations
//
//  Created by Muhammad Naviwala on 11/15/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonClicked(sender: UIButton) {
//        let queue = dispatch_get_global_queue(0,0)
//        dispatch_async(queue, {
//            self.animateMask()
//            dispatch_sync(dispatch_get_main_queue(), {
//                self.performSegueWithIdentifier("segueToProfileViewController", sender: self)
//            })
//        })

        let delayTime = 0.7
        
        basicAnimation()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayTime * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.performSegueWithIdentifier("segueToProfileViewController", sender: self)
        });
    }
    
    func basicAnimation() {
        self.whiteView.alpha = 0
        self.whiteView.layer.zPosition = 10 // make sure the white view is on the very top
        UIView.animateWithDuration(0.7, delay: 0.0, options: .CurveEaseOut, animations: {
            self.whiteView.alpha = 1
            }, completion: { finished in
                // do something for completion of needed
        })
    }
    
}