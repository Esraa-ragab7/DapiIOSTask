//
//  SiteTableViewCell.h
//  DapiIOSTask
//
//  Created by Esraa Mohamed Ragab on 19/02/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiteTableViewCell : UITableViewCell

// MARK:- Outlets
@property (weak, nonatomic) IBOutlet UIImageView *siteImageView;
@property (weak, nonatomic) IBOutlet UILabel *siteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteContentLengthLabel;

-(void) displayData:(NSString*)title contentLength:(NSString*) contentLength;

@end

NS_ASSUME_NONNULL_END
