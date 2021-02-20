//
//  SiteTableViewCell.m
//  DapiIOSTask
//
//  Created by Esraa Mohamed Ragab on 19/02/2021.
//

#import "SiteTableViewCell.h"

@implementation SiteTableViewCell

-(void) displayData:(NSString*)title contentLength:(NSString*) contentLength {
    [_siteTitleLabel setText:title];
    if ([contentLength isEqualToString:@""]) {
        [_siteContentLengthLabel setHidden:YES];
        [_siteImageView setHidden:YES];
    } else {
        [_siteContentLengthLabel setHidden:NO];
        [_siteImageView setHidden:NO];
        [_siteContentLengthLabel setText:contentLength];
        NSURL *url = [NSURL URLWithString:([NSString stringWithFormat:@"http://%@/favicon.ico",title])];
        NSData *data = [NSData dataWithContentsOfURL:url];
        _siteImageView.image = [UIImage imageWithData: data];
    }
}

@end
