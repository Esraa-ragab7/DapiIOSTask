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

- (NSMutableArray *)contentLength {
    if (!_contentLength) {
        _contentLength = [[NSMutableArray alloc] init];
        [_contentLength addObjectsFromArray:@[@"", @"", @"", @"", @"", @"", @"", @""]];
    }
    return _contentLength;
}

// MARK:- ViewController Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self urls];
    [self contentLength];
    [_sitesTableView registerNib:[UINib nibWithNibName:@"SiteTableViewCell" bundle:nil] forCellReuseIdentifier:@"SiteTableViewCell"];
}

// MARK: - Button Actions
- (IBAction)startButtonAction:(UIButton *)sender {
    [sender setHidden:YES];
    
    // semaphore control concurrency in our app by allowing us to lock n number of threads.
    NSInteger kMaxConcurrent = 1;
    dispatch_semaphore_t sema = dispatch_semaphore_create(kMaxConcurrent);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    for(NSInteger i=0 ; i < _urls.count ; i++){
        dispatch_async(queue, ^{
            // Lock shared resource access
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            [self callApi:i completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                [self changeContentLength:(NSHTTPURLResponse *) response index:i];
                // Update the UI on the main thread
                dispatch_sync(dispatch_get_main_queue(),^{
                    [self->_sitesTableView reloadData];
                    [self->_sitesTableView layoutIfNeeded];
                    // Release the lock
                    dispatch_semaphore_signal(sema);
                });
            }];
        });
    }
}

-(void)changeContentLength:(NSHTTPURLResponse*)httpResponse index:(NSInteger)index{
    long statusCode = (long)[httpResponse statusCode];
    if (statusCode > 199 && statusCode < 300) {
        [self->_contentLength replaceObjectAtIndex:index withObject:[NSByteCountFormatter stringFromByteCount:httpResponse.expectedContentLength countStyle:NSByteCountFormatterCountStyleBinary]];
    } else {
        [self->_contentLength replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld", statusCode]];
    }
}

-(void)callApi:(NSInteger)index completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", self->_urls[index]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDataTask *data = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [data resume];
}

// MARK:- TableView DataSource Methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = @"SiteTableViewCell";
    SiteTableViewCell *cell = [_sitesTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell displayData:_urls[indexPath.row] contentLength:[_contentLength objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _urls.count;
}

@end
