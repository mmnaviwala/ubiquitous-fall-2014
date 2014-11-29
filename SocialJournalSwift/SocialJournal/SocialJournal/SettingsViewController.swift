import UIKit

class SettingsViewController: UIViewController {
    @IBAction func changePassword(sender: AnyObject) {
    }
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var newsFeedLabel: UILabel!
    
    @IBAction func signOut(sender: AnyObject) {
    }
    
    @IBOutlet weak var followingSwitch: UISwitch!

    @IBOutlet weak var followerSwitch: UISwitch!
    
    
    @IBOutlet weak var newsFeedSwitch: UISwitch!
    
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
