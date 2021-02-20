//
//  HomeViewController.m
//  DapiIOSTask
//
//  Created by Esraa Mohamed Ragab on 19/02/2021.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (NSArray *)urls {
    if (!_urls) {
        _urls = @[@"apple.com", @"spacex.com", @"dapi.co", @"facebook.com", @"microsoft.com", @"amazon.com", @"boomsupersonic.com", @"twitter.com"];
    }
    return _urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urls];
    [_sitesTableView registerNib:[UINib nibWithNibName:@"SiteTableViewCell" bundle:nil] forCellReuseIdentifier:@"SiteTableViewCell"];
}


- (IBAction)startButtonAction:(UIButton *)sender {
    NSLog(@"test 1 2 3");
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = @"SiteTableViewCell";
    SiteTableViewCell *cell = [_sitesTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell displayData:_urls[indexPath.row] contentLength:@""];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _urls.count;
}


@end
