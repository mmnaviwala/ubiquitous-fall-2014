import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func changePassword(sender: AnyObject) {
        
        //let alertController: UIAlertController = UIAlertController(title: "Change Your Password", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
        
        let alertController = UIAlertController(title: "Change Your Password", message: "A standard alert.", preferredStyle: .Alert)
        
        //Create and add the Cancel action

            
        let cancelAction = UIAlertAction(title: "Cancel",style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in })
        
        alertController.addAction(cancelAction)
        //Create and add first option action
        
        let confirmAction = UIAlertAction(title: "Confirm",style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in
            var currentUser = PFUser.currentUser()
            
            if let textFields = alertController.textFields{
                
                let theTextFields = textFields as [UITextField]
                
                let oldPassword = theTextFields[0].text
                let newPassword = theTextFields[1].text
                let confirmPassword = theTextFields[2].text
              /*  if currentUser.password != oldPassword{
                    
                    let alertController3 = UIAlertController(title: "Error", message: "Old Password is wrong", preferredStyle: .Alert)
                    
                    let OkAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in })
                    
                    alertController3.addAction(OkAction)
                    alertController3.popoverPresentationController?.sourceView = sender as UIView;
                    self.presentViewController(alertController3, animated: true, completion: nil)

                    
                }*/
                
                if confirmPassword != newPassword{
                    let alertController2 = UIAlertController(title: "Error", message: "New and Confirm password Doesn't Match", preferredStyle: .Alert)
                    
                    let OkAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in })
                    
                    alertController2.addAction(OkAction)
                    alertController2.popoverPresentationController?.sourceView = sender as UIView;
                    self.presentViewController(alertController2, animated: true, completion: nil)
                }
                
                currentUser.password = newPassword
                currentUser.saveInBackground()
            }
            
        
        })
        
        alertController.addAction(confirmAction)
        
       /* let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -&gt; Void in
            //Code for launching the camera goes here
        }*/
        //actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
       
       alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Old Password"
            //textField.keyboardType = .EmailAddress
            textField.secureTextEntry = true
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New Password"
            textField.secureTextEntry = true
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New Password Confirmation"
            textField.secureTextEntry = true
        }
        
        //We need to provide a popover sourceView when using it on iPad
        alertController.popoverPresentationController?.sourceView = sender as UIView;
        
        //Present the AlertController
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followerLabel: UILabel!  //CommentsLabel
    
    @IBOutlet weak var newsFeedLabel: UILabel!  //HeartsLabel
    
    @IBAction func signOut(sender: AnyObject) {
        
        PFUser.logOut()
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("signInView")
        self.showViewController(vc as UIViewController, sender: vc)
    }
    
    @IBOutlet weak var followingSwitch: UISwitch!

    @IBOutlet weak var followerSwitch: UISwitch! //Comments Switch
    
    
    @IBOutlet weak var newsFeedSwitch: UISwitch! // Hearts Switch
    
    var button: HamburgerButton! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.followingLabel.layer.cornerRadius = 8
        self.followingLabel.layer.masksToBounds = true
        self.followerLabel.layer.cornerRadius = 8
        self.followerLabel.layer.masksToBounds = true
        self.newsFeedLabel.layer.cornerRadius = 8
        self.newsFeedLabel.layer.masksToBounds = true
        
        self.button = HamburgerButton(frame: CGRectMake(20, 20, 60, 60))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.button.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: self.button)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
