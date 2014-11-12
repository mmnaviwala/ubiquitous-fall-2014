//
//  AllEntriesTableViewController.m
//  SocialJournal
//
//  Created by James Garcia on 10/29/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import "AllEntriesTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AllEntriesTableViewCell.h"

@interface AllEntriesTableViewController ()
@property CGSize constraint;
@end

@implementation AllEntriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //broken white [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    //H [UIColor colorWithRed:(135/255.0) green:(136/255.0) blue:(140/255.0) alpha:1.0];
    //trapped [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0];
    //chinese laque [UIColor colorWithRed:(224/255.0) green:(22/255.0) blue:(22/255.0) alpha:1.0];
    //coulour [UIColor colorWithRed:(6/255.0) green:(20/255.0) blue:(77/255.0) alpha:1.0];
    
    
    self.constraint = CGSizeMake(70, 70);
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0]}];
    self.navigationController.navigationBar.translucent = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllEntriesTableViewCell *cell = (AllEntriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AllEntriesTableCell"];
    if (cell == nil)
    {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"AllEntriesTableViewCell" owner:self options:nil];
        cell = [xib objectAtIndex:0];
    }
    
    cell.tintColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    
    //cell.profilePhoto.image = [self imageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cdn.meme.am/instances/500x/51501899.jpg"]]] scaledToSize:self.constraint]; //set image from api

    
//    //Alternate Code
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"postCellBackground.png"]];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"postCellBackgroundSelected.png"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"AllEntriesToJournalDetail" sender:self];
    dispatch_async(dispatch_get_main_queue(), ^{});
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
