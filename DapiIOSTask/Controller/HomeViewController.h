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

// MARK:- Outlets
@property (weak, nonatomic) IBOutlet UITableView *sitesTableView;

// MARK:- Actions
- (IBAction)startButtonAction:(UIButton *)sender;

// MARK:- Propertires
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSMutableArray *contentLength;


@end

