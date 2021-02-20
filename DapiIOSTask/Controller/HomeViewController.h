//
//  HomeViewController.h
//  DapiIOSTask
//
//  Created by Esraa Mohamed Ragab on 19/02/2021.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SiteTableViewCell.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *sitesTableView;

@property (nonatomic, strong) NSArray *urls;

- (IBAction)startButtonAction:(UIButton *)sender;

@end

