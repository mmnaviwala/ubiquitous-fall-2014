//
//  ProfileViewController.m
//  SocialJournal
//
//  Created by James Garcia on 11/12/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import "ProfileViewController.h"
#import "AllEntriesTableViewCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0]}];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
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
    
//    PFObject *currentCellObject = [self.dataFromParse objectAtIndex:indexPath.row];
//    cell.postTitle.text = currentCellObject[@"title"];
//    cell.postPreview.text = currentCellObject[@"entry"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return @"Posts";
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 15)];
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0 ,0,tableView.frame.size.width,20)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0]];
    tempLabel.backgroundColor= [UIColor clearColor];
    tempLabel.textColor = [UIColor colorWithRed:(224/255.0) green:(22/255.0) blue:(22/255.0) alpha:1.0];
    tempLabel.font = [UIFont fontWithName:@"HelveticaNew" size:15];
    tempLabel.font = [UIFont boldSystemFontOfSize:15];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    if (section == 0) {
        tempLabel.text=@"Posts";
    }
    
    [headerView addSubview:tempLabel];
    
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ProfileToPost" sender:self];
    dispatch_async(dispatch_get_main_queue(), ^{});
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
