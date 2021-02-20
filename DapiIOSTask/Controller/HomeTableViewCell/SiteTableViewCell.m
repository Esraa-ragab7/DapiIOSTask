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
        if(![contentLength containsString:@"B"] && ![contentLength containsString:@"b"]) {
            _siteImageView.image = [UIImage imageNamed:@"failure-icon"];
        } else {
            NSURL *url = [NSURL URLWithString:([NSString stringWithFormat:@"https://%@/favicon.ico",title])];
            NSData *data = [NSData dataWithContentsOfURL:url];
            _siteImageView.image = [UIImage imageWithData: data];
        }
    }
}

@end
