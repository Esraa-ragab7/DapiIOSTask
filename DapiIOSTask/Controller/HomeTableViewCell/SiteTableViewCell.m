//
//  SiteTableViewCell.m
//  DapiIOSTask
//
//  Created by Esraa Mohamed Ragab on 19/02/2021.
//

#import "SiteTableViewCell.h"

@implementation SiteTableViewCell

// MARK:- DisplayData Method
-(void) displayData:(NSString*)title contentLength:(NSString*) contentLength {
    [_siteTitleLabel setText:title];
    // in the case of an empty string, the HTTP get request didn't run yet
    if ([contentLength isEqualToString:@""]) {
        [_siteContentLengthLabel setHidden:YES];
        [_siteImageView setHidden:YES];
    } else {
        [_siteContentLengthLabel setHidden:NO];
        [_siteImageView setHidden:NO];
        [_siteContentLengthLabel setText:contentLength];
        // in the case of the string doesn't contain B and b, this means a failure request
        if(![contentLength containsString:@"B"] && ![contentLength containsString:@"b"]) {
            _siteImageView.image = [UIImage imageNamed:@"failure-icon"];
        } else {
            // display the favicon
            NSURL *url = [NSURL URLWithString:([NSString stringWithFormat:@"https://%@/favicon.ico",title])];
            NSData *data = [NSData dataWithContentsOfURL:url];
            _siteImageView.image = [UIImage imageWithData: data];
        }
    }
}

@end
